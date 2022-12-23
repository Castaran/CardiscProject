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
    @Published var lobby: Lobby?
    @Published var gameId = ""
    @Published var joinSucceed = false
    @Published var amountSelected = 0
    
    @Published var players: [LobbyPlayer] = []
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        self.gameManager.$players
            .sink(receiveValue: { players in
                self.players = players
            })
            .store(in: &cancellables)
    }
    
    private var isLoading = false
    
    func submitSession() {
        //..
    }
    
    func sendChatMessage() {
        //..
    }
    
    func nextRound() {
        //..
    }
    
    func joinGame() {
        DispatchQueue.main.async {
            self.gameManager.joinGame(sessionAuth: self.gameId) { data in
                self.joinSucceed = true
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
    
    func startGame() {
        DispatchQueue.main.async {
            self.gameManager.startGame()
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
