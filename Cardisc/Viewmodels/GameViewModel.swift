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
    @Published var lobby: Lobby?
    @Published var gameId = ""
    @Published var joinSucceed = false
    @Published var rounds = 2
    @Published var duration = 60
    
    @Published var players: [LobbyPlayer] = []
    @Published var game = Game(cards: [], roundDuration: 0)
    @Published var gameInProgress = false
    @Published var currentCard: Card = Card(id: "", number: 0, name: "", body: "", type: 0)
    @Published var answer: String = ""
    @Published var answers: [Answer] = []
    @Published var nextView: Bool = false
    
    private var cancellables: [AnyCancellable] = []
    private var isLoading = false
    
    init() {
        self.gameManager.$players
            .sink(receiveValue: { players in
                self.players = players
            })
            .store(in: &cancellables)
        
        self.gameManager.$game
            .sink(receiveValue: { game in
                self.game = game
                self.gameInProgress = true
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
    }
    
    func submitAnswer() {
        DispatchQueue.main.async {
            self.gameManager.submitAnswer(answer: self.answer)
            self.nextView = true
        }
    }
    
    func sendChatMessage(msg: String) {
        DispatchQueue.main.async {
            self.gameManager.sendChatMessage(msg: msg)
        }
    }
    
    func nextRound() {
        //..
    }
    
    func joinGame() {
        DispatchQueue.main.async {
            self.gameManager.joinGame(sessionAuth: self.gameId) { data in
                self.joinSucceed = true
                self.gameInProgress = false
                self.lobby = data
            }
        }
        
    }
    
    func leaveGame() {
        DispatchQueue.main.async {
            if let lobby = self.lobby {
                self.gameManager.leaveGame(sessionCode: lobby.sessionCode)
                self.lobby = nil
            }
            
        }
    }
    
    func startGame(rounds: Int, duration: Int) {
        DispatchQueue.main.async {
            self.gameManager.startGame(rounds: rounds, duration: duration)
        }
    }
    
    func createGame() {
        DispatchQueue.main.async {
            self.gameManager.createGame() { data in
                self.lobby = data
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
