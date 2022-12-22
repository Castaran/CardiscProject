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
    
    @Published var players: [lobbyPlayerDto] = []
    @Published var signalRService: SignalRService?
    private var apiService = ApiService()
    private let defaults = UserDefaults.standard
    
    private var currentUser: userDto?
    
    var anyCancellable: AnyCancellable? = nil
    
    init() {
        
        if let signalRService = self.signalRService {
            anyCancellable = signalRService.objectWillChange.sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
        }

        
        if let token = defaults.string(forKey: "X-AUTHTOKEN") {
            if let url = URL(string: Constants.SIGNALR_BASE_URL + token){
                self.signalRService = SignalRService(url: url)
                
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
            else {
                print("incorrect url")
            }
        }
        else {
            print ("no key found")
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
    
    func joinGame(sessionAuth: String, completion:@escaping (lobbyResponseDto) -> ()) {
        let body: [String: AnyHashable] = [
            "sessionAuth": sessionAuth
        ]
        apiService.postData(body: body, url: Constants.API_BASE_URL + "session/join", model: lobbyResponseDto.self) { data in
            self.signalRService?.players = data.players
            completion(data)
            if let signalRService = self.signalRService {
                signalRService.joinMessageGroup()
            }
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
    
    func createGame(completion:@escaping (lobbyResponseDto) -> ()) {
        apiService.postData(body: nil, url: "\(Constants.API_BASE_URL)session/create", model: lobbyResponseDto.self) { data in
            self.signalRService?.players = data.players
            completion(data)
            if let signalRService = self.signalRService {
                signalRService.joinMessageGroup()
            }
        } failure: { error in
            print(error)
        }
    }
    
    func startGame() {
        apiService.postDataWithoutReturn(body: nil, url: Constants.API_BASE_URL + "session/start")
    }
    
    func changeState() {
        let body: [String: AnyHashable] = [
            "ready": true
        ]
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/ready")
    }
}
