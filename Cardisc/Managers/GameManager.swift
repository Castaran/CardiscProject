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
    
    private var apiService = ApiService()
    private let defaults = UserDefaults.standard
    @Published var signalRService = SignalRService()
    
    private var currentUser = userDto(id: "", username: "", email: "", picture: "")
    private var cancellables: [AnyCancellable] = []
    
    //Game variables, these change on the actions of any user in the session
    @Published var game = Game(cards: [], roundDuration: 0)
    @Published var gameIndex: Int = 0
    @Published var currentCard: Card = Card(id: "", number: 0, name: "", body: "", type: 0)
    @Published var players: [LobbyPlayer] = []
    @Published var answers: [Answer] = []
    @Published var chatMessages: [ChatMessage] = []
    @Published var startedGame: Bool = false
    
    
    init() {
        self.syncVariables()
        
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
    
    
    //Keeps the variables synchronised between the manager and the SignalR Client
    private func syncVariables() {
        self.signalRService.$players
            .sink(receiveValue: { players in
                self.players = players
            })
            .store(in: &cancellables)
        
        self.signalRService.$gameIndex
            .sink(receiveValue: { gameIndex in
                self.gameIndex = gameIndex+1
            })
            .store(in: &cancellables)
        
        self.signalRService.$game
            .sink(receiveValue: { game in
                self.game = game
            })
            .store(in: &cancellables)
        
        self.signalRService.$answers
            .sink(receiveValue: { answers in
                self.answers = answers
            })
            .store(in: &cancellables)
        
        self.signalRService.$chatMessages
            .sink(receiveValue: { chatMessages in
                self.chatMessages = chatMessages
            })
            .store(in: &cancellables)
        
        self.signalRService.$currentCard
            .sink(receiveValue: { currentCard in
                self.currentCard = currentCard
            })
            .store(in: &cancellables)
        
        self.signalRService.$startedGame
            .sink(receiveValue: { startedGame in
                self.startedGame = startedGame
            })
            .store(in: &cancellables)
    }
    
    //Submits an answer to the API
    func submitAnswer(answer: String) {
        let body: [String: AnyHashable] = [
            "answer": answer
        ]
        
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/submit")
    }
    
    //Sends a chatmessage to the API
    func sendChatMessage(msg: String) {
        let body: [String: AnyHashable] = [
            "message": msg
        ]
        
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/message")
        signalRService.chatMessages.append(ChatMessage(username: nil, message: msg))
    }
    
    //Tells the API that the next round is ready to start
    func nextRound() {
        let body: [String: AnyHashable] = [
            "conclussion": ""
        ]
        
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/next")
    }
    
    //Tells the API that the game is completed
    func endGame() {
        apiService.postDataWithoutReturn(body: nil, url: Constants.API_BASE_URL + "session/end")
    }
    
    //Joins a session and gets the lobby object from the API
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
    
    //Let the current user leave the session he is in
    func leaveGame(sessionCode: String) {
        let body: [String: AnyHashable] = [
            "sessionCode": sessionCode
        ]
        
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/leave")
        
    }
    
    //Creates a new session
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
    
    //Tells the API that the session/game is ready to start
    func startGame(rounds: Int, duration: Int) {
        let body: [String: AnyHashable] = [
            "rounds": rounds+1,
            "duration": duration
        ]
        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "session/start")
    }
    
    //Changes the state of the player
    func changeState() {
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
