//
//  SessionViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation
import SignalRClient
import Combine
import UIKit

class GameViewModel: ObservableObject {
    
    private let gameManager = GameManager()
    
    @Published var isPresentingConfirm: Bool = false
    @Published var showConfirmation: Bool = false
    
    //Loading states
    @Published var isLoadingJoinSession: Bool = false
    @Published var isLoadingStartingSession: Bool = false
    @Published var isLoadingMainMenu: Bool = false
    @Published var nextRoundStarted: Bool = false
    @Published var submittedAnswer: Bool = false
    @Published var startedGame: Bool = false
    @Published var finishedGame: Bool = false
    @Published var joinedGame: Bool = false
    
    //Game data
    @Published var isHost: Bool = false
    @Published var playerReady: Bool = false
    @Published var rounds: Int = 0
    @Published var players: [LobbyPlayer] = []
    @Published var game = Game(cards: [], roundDuration: 0)
    @Published var lobby: Lobby = Lobby(id: "", hostId: "", sessionCode: "", created: "", sessionAuth: "", players: [])
    @Published var currentCard: Card = Card(id: "", number: 0, name: "", body: "", type: 0)
    @Published var gameIndex: Int = 0
    @Published var gameId = ""
    @Published var answer: String = ""
    @Published var scalableAnswer: Double = 3
    @Published var answerGiven: Bool = false
    @Published var averageScalable: Double = 0
    @Published var summaryMPC: [String: Int] = ["A": 0, "B": 0, "C": 0, "D": 0]
    @Published var answers: [Answer] = []
    @Published var chatMessage: String = ""
    @Published var chatMessages: [ChatMessage] = []
    @Published var keyboardHeigtChat: CGFloat = 0
    @Published var chatting: Bool = false
    @Published var conclusion = ""
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        self.syncVariables()
    }
    
    //Keeps the variables synchronised between the viewmodel and the manager
    private func syncVariables() {
        self.gameManager.$players
            .sink(receiveValue: { players in
                self.players = players
            })
            .store(in: &cancellables)
        
        self.gameManager.$gameIndex
            .sink(receiveValue: { gameIndex in
                self.gameIndex = gameIndex
                self.continueGame()
            })
            .store(in: &cancellables)
        
        self.gameManager.$game
            .sink(receiveValue: { game in
                self.game = game
                self.startGame()
            })
            .store(in: &cancellables)
        
        self.gameManager.$answers
            .sink(receiveValue: { answers in
                self.procesAnswers(answers: answers)
            })
            .store(in: &cancellables)
        
        self.gameManager.$chatMessages
            .sink(receiveValue: { chatMessages in
                self.chatMessages = chatMessages
            })
            .store(in: &cancellables)
    }
    
    // Submits an answer to the session
    func submitAnswer() {
        DispatchQueue.main.async {
            if(self.answer != "") {
                self.gameManager.submitAnswer(answer: self.answer)
                self.submittedAnswer = true
                self.answerGiven = false
                self.nextRoundStarted = false
            }
        }
    }
    
    // Sends a chatmessage from current user to the session
    func sendChatMessage() {
        if(chatMessage != "") {
            DispatchQueue.main.async {
                self.gameManager.sendChatMessage(msg: self.chatMessage)
                self.chatMessage = ""
            }
        }
    }
    
    // Gets executed by the gamehost, marks the current round finished and asks for a new round
    func nextRound() {
        if(self.isHost) {
            self.gameManager.nextRound(conclusion: self.conclusion)
        }
    }
    
    // Summarises the answers for special card types
    func procesAnswers(answers: [Answer]) {
        self.answers = answers
        if(currentCard.type == 1) {
            var sum: Double = 0.0
            for a in answers {
                sum += Double(a.answer) ?? 0
            }
            self.averageScalable = sum/Double(answers.count)
        }
        else if(currentCard.type == 2) {
            self.summaryMPC = ["A": 0, "B": 0, "C": 0, "D": 0]
            for a in answers {
                switch a.answer {
                case "A":
                    summaryMPC["A"]! += 1
                case "B":
                    summaryMPC["B"]! += 1
                case "C":
                    summaryMPC["C"]! += 1
                case "D":
                    summaryMPC["D"]! += 1
                default:
                    print("Error: wrong answer!")
                }
            }
        }
    }
    
    // Gets executed when a new round is started
    func continueGame() {
        DispatchQueue.main.async {
            self.answer = ""
            self.conclusion = ""
            self.scalableAnswer = 3
            self.chatMessage = ""
            self.summaryMPC = ["A": 0, "B": 0, "C": 0, "D": 0]
            if(self.game.cards.count > 0) {
                if(self.gameIndex < self.game.cards.count) {
                    self.currentCard = self.game.cards[self.gameIndex]
                    self.submittedAnswer = false
                    self.nextRoundStarted = true
                }
                else {
                    self.endSession()
                }
            }
        }
    }
    
    // Joins an existing game with a gameId
    func joinGame() {
        DispatchQueue.main.async {
            self.isLoadingJoinSession = true
            self.gameManager.joinGame(sessionAuth: self.gameId) { data in
                self.isHost = false
                self.lobby = data
                self.joinedGame = true
                self.isLoadingJoinSession = false
            }
        }
    }
    
    // Leaves a game, could be a self hosted game or a joined one
    func leaveGame() {
        DispatchQueue.main.async {
            self.gameManager.leaveGame(sessionCode: self.lobby.sessionCode)
            self.lobby = Lobby(id: "", hostId: "", sessionCode: "", created: "", sessionAuth: "", players: [])
            self.chatMessages = []
        }
    }
    
    // Starts the game, could be a hosted or a joined one. If user is the host, then a start request is sent to the API to let all players know the game has been started
    func startGame() {
        DispatchQueue.main.async {
            if(self.isHost && self.game.cards.count == 0) {
                self.rounds += 2
                self.gameManager.startGame(rounds: self.rounds)
            }
            else {
                if(self.game.cards.count > 0) {
                    self.isLoadingStartingSession = true
                    self.currentCard = self.game.cards[self.gameIndex]
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.startedGame = true
                        self.isLoadingStartingSession = false
                    }
                }
            }
        }
    }
    
    // Creates a session where the current player is host of
    func createGame(completion: @escaping ()->()) {
        self.isLoadingStartingSession = true
        self.gameManager.createGame() { data in
            DispatchQueue.main.async {
                self.isLoadingStartingSession = false
                self.lobby = data
                self.isHost = true
                self.startedGame = false
                completion()
            }
        }
    }
    
    // Ends the session if executed
    func endSession() {
        self.isLoadingMainMenu = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if(self.isHost) {
                self.gameManager.endGame(conclusion: self.conclusion)
            }
            self.finishedGame = true
            self.isLoadingMainMenu = false
        }
    }
    
    // Changes the players state
    func changeState() {
        DispatchQueue.main.async {
            self.gameManager.changeState()
            self.playerReady.toggle()
        }
    }
    
    // Shares the game code via supported social media platforms
    func shareGame() {
        let activityViewController = UIActivityViewController(
            activityItems: ["Join my Cardisc game with the following GameID: \(self.lobby.sessionCode)"],
            applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
}
