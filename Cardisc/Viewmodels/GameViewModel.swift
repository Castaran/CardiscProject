//
//  SessionViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation
import SignalRClient
import Combine

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
    @Published var rounds: Int = 2
    @Published var players: [LobbyPlayer] = []
    @Published var game = Game(cards: [], roundDuration: 0)
    @Published var lobby: Lobby = Lobby(id: "", hostId: "", sessionCode: "", created: "", sessionAuth: "", players: [])
    @Published var currentCard: Card = Card(id: "", number: 0, name: "", body: "", type: 0)
    @Published var gameIndex: Int = 0
    @Published var gameId = ""
    @Published var answer: String = ""
    @Published var answers: [Answer] = []
    @Published var chatMessage: String = ""
    @Published var chatMessages: [ChatMessage] = []
    @Published var conclusion = ""
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        self.syncVariables()
    }
    
    //Keeps the variables synchronised between the viewmodel and the manager
    private func syncVariables() {
        self.gameManager.$players
            .sink(receiveValue: { players in
                DispatchQueue.main.async {
                    self.players = players
                }
            })
            .store(in: &cancellables)
        
        self.gameManager.$gameIndex
            .sink(receiveValue: { gameIndex in
                self.gameIndex = gameIndex
            })
            .store(in: &cancellables)
        
        self.gameManager.$game
            .sink(receiveValue: { game in
                self.game = game
                if(game.cards.count > 0) {
                    self.currentCard = self.game.cards[self.gameIndex]
                }
            })
            .store(in: &cancellables)
        
        self.gameManager.$answers
            .sink(receiveValue: { answers in
                self.answers = answers
            })
            .store(in: &cancellables)
        
        self.gameManager.$chatMessages
            .sink(receiveValue: { chatMessages in
                self.chatMessages = chatMessages
            })
            .store(in: &cancellables)
        
        self.gameManager.$currentCard
            .sink(receiveValue: { currentCard in
                self.currentCard = currentCard
                if(!self.isHost){
                    self.nextRound()
                }
            })
            .store(in: &cancellables)
        
        self.gameManager.$startedGame
            .sink(receiveValue: { startedGame in
                if(startedGame) {
                    self.startGame()
                }
            })
            .store(in: &cancellables)
    }
    
    func submitAnswer() {
        DispatchQueue.main.async {
            self.gameManager.submitAnswer(answer: self.answer)
            self.submittedAnswer = true
            self.nextRoundStarted = false
        }
    }
    
    func sendChatMessage() {
        if(chatMessage != "") {
            DispatchQueue.main.async {
                self.gameManager.sendChatMessage(msg: self.chatMessage)
                self.chatMessage = ""
            }
        }
    }
    
    func nextRound() {
        DispatchQueue.main.async {
            self.gameManager.nextRound(conclusion: self.conclusion)

            if(self.gameIndex <= self.rounds) {
                self.nextRoundStarted = true
            }
            else {
                self.endSession()
            }
            
            self.answer = ""
            self.conclusion = ""
            self.submittedAnswer = false
        }
    }
    
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
    
    func leaveGame() {
        DispatchQueue.main.async {
            self.gameManager.leaveGame(sessionCode: self.lobby.sessionCode)
        }
        self.lobby = Lobby(id: "", hostId: "", sessionCode: "", created: "", sessionAuth: "", players: [])
        self.chatMessages = []
    }
    
    func startGame() {
        self.isLoadingStartingSession = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.gameManager.startGame(rounds: self.rounds) {
                self.startedGame = true
                self.isLoadingStartingSession = false
            }
            
        }
    }
    
    func createGame(completion: @escaping ()->()) {
        self.isLoadingStartingSession = true
        self.gameManager.createGame() { data in
            DispatchQueue.main.async {
                self.lobby = data
                self.isHost = true
                self.startedGame = false
                self.isLoadingStartingSession = false
                completion()
            }
        }
    }
    
    func endSession() {
        self.isLoadingMainMenu = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.gameManager.endGame(conclusion: self.conclusion)
            self.isLoadingMainMenu = false
            self.finishedGame = true
        }
    }
    
    func changeState() {
        DispatchQueue.main.async {
            self.gameManager.changeState()
            self.playerReady.toggle()
        }
    }
    
}
