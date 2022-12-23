//
//  SessionManager.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation
import SwiftUI
import Combine

class GameManager: ObservableObject {
    
    @Published var players: [LobbyPlayer] = []
    @Published var signalRService = SignalRService()
    private var apiService = ApiService()
    private let defaults = UserDefaults.standard
    
    private var currentUser: userDto?
    private var cancellables: [AnyCancellable] = []
    
    init() {
        self.signalRService.$players
            .sink(receiveValue: { players in
                self.players = players
            })
            .store(in: &cancellables)
        
        if let currentUser = UserDefaults.standard.data(forKey: "user") {
            do {
                let decoder = JSONDecoder()
                self.currentUser = try decoder.decode(loginResponseDto.self, from: currentUser).user
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        else {
            print("No user found")
        }
        
        
    }
    
    func submitSession(id: Int, completion:@escaping (userDto) -> ()) {
        
    }
    
    func sendChatMessage(id: Int, completion:@escaping (userDto) -> ()) {
        
    }
    
    func nextRound(id: Int, completion:@escaping (userDto) -> ()) {
        
    }
    
    func endGame() {
        apiService.postDataWithoutReturn(body: nil, url: Constants.API_BASE_URL + "session/end")
    }
    
    func joinGame(sessionAuth: String, completion:@escaping (Lobby) -> ()) {
        let body: [String: AnyHashable] = [
            "sessionAuth": sessionAuth
        ]
        apiService.postData(body: body, url: Constants.API_BASE_URL + "session/join", model: lobbyResponseDto.self) { data in
            let lobby = data.toDomainModel()
            self.signalRService.players = lobby.players
            self.signalRService.joinMessageGroup()
            completion(lobby)
        } failure: { error in
            print(error)
        }
        
    }
    
    func leaveGame(sessionCode: String) {
        let body: [String: AnyHashable] = [
            "sessionCode": sessionCode
        ]
        
        print(sessionCode)
        
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/leave")
        
    }
    
    func createGame(completion:@escaping (Lobby) -> ()) {
        apiService.postData(body: nil, url: "\(Constants.API_BASE_URL)session/create", model: lobbyResponseDto.self)
        { data in
            let lobby = data.toDomainModel()
            self.signalRService.players = lobby.players
            self.signalRService.joinMessageGroup()
            completion(lobby)
        } failure: { error in
            print(error)
        }
    }
    
    func startGame() {
        apiService.postDataWithoutReturn(body: nil, url: Constants.API_BASE_URL + "session/start")
    }
    
    func changeState() {
        if let currentUser = self.currentUser {
            for p in players {
                if(p.username == currentUser.username) {
                    let body: [String: AnyHashable] = [
                        "ready": !p.ready
                    ]
                    apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/ready")
                }
            }
           
        }

    }
}
