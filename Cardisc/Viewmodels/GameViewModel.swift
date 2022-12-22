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
    @Published var lobbyResponseDto: lobbyResponseDto?
    @Published var gameId = ""
    @Published var joinSucceed = false
    @Published var amountSelected = 0
    
    @Published var players: [lobbyPlayerDto] = []
    
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
                if(data.players != nil) {
                    self.joinSucceed = true
                    self.lobbyResponseDto = data
                }
                else {
                    print("NEEEEEE")
                }
            }
        }
        
    }
    
    func leaveGame() {
        DispatchQueue.main.async {
            if let lobbyResponseDto = self.lobbyResponseDto {
                self.gameManager.leaveGame(sessionCode: lobbyResponseDto.sessionCode)
                self.lobbyResponseDto = nil
            }
            
        }
    }
    
    func startGame() {
        DispatchQueue.main.async {
            self.gameManager.startGame()
        }
        print("START GAME METHOD VIEWMODEL")
    }
    
    func createGame() {
        DispatchQueue.main.async {
            self.gameManager.createGame() { data in
                self.lobbyResponseDto = data
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
