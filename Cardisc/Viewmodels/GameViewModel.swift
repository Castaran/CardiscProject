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
    @Published var rounds = 2
    @Published var isHost: Bool = false
    
    //Loading states
    @Published var isLoadingHostGame: Bool = false
    @Published var isLoadingJoinSession: Bool = false
    

    //Game data
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
    @Published var nextView: Bool = false
    @Published var startedGame: Bool = false
    @Published var finishedGame: Bool = false
    
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
                    self.currentCard = self.game.cards[0]
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
            })
            .store(in: &cancellables)
        
        self.gameManager.$startedGame
            .sink(receiveValue: { startedGame in
                self.startGame()
                print("AKSLDJAKSJDLASKJDLAKJLKSJALDKJASLD")
            })
            .store(in: &cancellables)
    }
    
    func submitAnswer() {
        DispatchQueue.main.async {
            self.gameManager.submitAnswer(answer: self.answer)
            self.nextView = true
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
            self.gameManager.nextRound()
            self.answer = ""
            if(self.gameIndex <= self.rounds) {
                self.nextView = true
            }
            else {
                self.finishedGame = true
            }
        }
    }
    
    func joinGame() {
        DispatchQueue.main.async {
            self.gameManager.joinGame(sessionAuth: self.gameId) { data in
                self.isHost = false
                self.lobby = data
                self.nextView = true
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
        self.startedGame = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.gameManager.startGame(rounds: self.rounds)
            self.nextView = true
        }
    }
    
    func createGame(completion: @escaping ()->()) {
        self.gameManager.createGame() { data in
            DispatchQueue.main.async {
                self.isHost = true
                self.lobby = data
                completion()
            }
        }
    }
    
    func endSession() {
        DispatchQueue.main.async {
            self.gameManager.endGame()
        }
    }
    
    func changeState() {
        DispatchQueue.main.async {
            self.gameManager.changeState()
        }
    }
}
