//
//  JoinGameViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 12/12/2022.
//

import Foundation

class JoinGameViewModel: ObservableObject {
    
    private let gameManager = GameManager()
    private var isLoading = false
    @Published var lobbyResponseDto: lobbyResponseDto?
    @Published var gameId = ""
    
    init() {
        self.gameManager.createGame() { data in
            self.lobbyResponseDto = data
        }
    }
    
    func submitSession() {
        //..
    }
    
    func sendChatMessage() {
        //..
    }
    
    func nextRound() {
        //..
    }
    
    func endGame() {
        //..
    }
    
    func joinGame() {
        //..
    }
    
    func leaveGame() {
        //..
    }
    
    func createGame() {
        
    }
    
    func startGame() {
        //..
    }
    
    func changeState() {
        //..
    }
    
    func sessionHistory() {
        //..
    }
}
