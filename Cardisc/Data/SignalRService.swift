//
//  SignalR.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 04/12/2022.
//

import Foundation
import SignalRClient
import Combine

class SignalRService: ObservableObject {
    private let defaults = UserDefaults.standard
    private var connection: HubConnection
    private var apiService = ApiService()
    private var connectionId = ""
    
    //Game variables, these change on the actions of any user in the session
    @Published var players: [LobbyPlayer] = []
    @Published var game: Game = Game(cards: [], roundDuration: 0)
    @Published var answers: [Answer] = []
    
    public init() {
        // has to be created after logging in
        self.connection = HubConnectionBuilder(url: URL(string: Constants.SIGNALR_BASE_URL + defaults.string(forKey: "X-AUTHTOKEN")!)!)
            .withLogging(minLogLevel: .error)
            .build()
        
        connection.on(method: "newConnection", callback: {
            (id: String) in
            print("NEW CONNECTION ACTION PERFORMED")
            self.connectionId = id
        })
        
        connection.on(method: "readyStateChanged", callback: {
            (player: LobbyPlayer) in
            print("READY STATE CHANGE ACTION PERFORMED")
            self.onReadyStateChange(player: player)
        })
        
        connection.on(method: "newPlayer", callback: {
            (player: LobbyPlayer) in
            print("NEW PLAYER IN THE ROOM")
            self.onNewPlayer(player: player)
        })
        
        connection.on(method: "playerLeft", callback: {
            (player: playerLeftDto) in
            print("PLAYER LEFT ACTION PERFORMED")
            self.onPlayerLeft(player: player)
        })
        
        connection.on(method: "startGame", callback: {
            (game: startGameDto) in
            print("START GAME ACTION PERFORMED")
            self.onGameStarted(game: game.toDomainModel())
        })
        
        connection.on(method: "newMessage", callback: {
            print("NEW MESSAGE ACTION PERFORMED")
            //Method te perform
        })
        
        connection.on(method: "newAnswer", callback: {
            (player: userDto, answer: String) in
            print("NEW ANSWER ACTION PERFORMED: \(answer) + \(player.id)")
            self.onNewAnswer(user: player.toDomainModel(), answer: answer)
        })
        
        connection.on(method: "nextRound", callback: {
            print("NEXT ROUND ACTION PERFORMED")
            //Method te perform
        })
        
        connection.on(method: "endSession", callback: {
            print("END SESSION ACTION PERFORMED")
            //Method te perform
        })
        connection.on(method: "close", callback: {
            print("CONN CLOSED")
            //Method te perform
        })
        connection.start()
    }
    
    
    public func joinMessageGroup() {
        let body: [String: AnyHashable] = [
            "connectionId": self.connectionId,
        ]

        apiService.postDataWithoutReturn(body: body, url: Constants.API_BASE_URL + "joinGrp")
    }

    
    private func onNewConnection(id: String) {
        //..
    }
    
    private func onClose() {
        //..
    }
    
    private func onReadyStateChange(player: LobbyPlayer) {
        var index = 0
        for p in self.players {
            if(p.username == player.username) {
                self.players[index].ready.toggle()
                print("Player \(player.username) status changed to: \(self.players[index].ready)")
            }
            index+=1
        }
        
    }
    
    private func onNewPlayer(player: LobbyPlayer) {
        //is there a better way?
        var contains = false
        for p in self.players {
            if(player.id == p.id) {
                contains = true
                break
            }
        }
        if(!contains) {
            self.players.append(player)
        }
    }
    
    private func onPlayerLeft(player: playerLeftDto) {
        var index = 0
        for p in self.players {
            if(p.username == player.name) {
                self.players.remove(at: index)
                index+=1
            }
        }
    }
    
    private func onGameStarted(game: Game) {
        self.game = game
    }
    
    private func onNewMessage(user: userDto, cardIndex: Int, message: String) {
        //..
    }
    
    private func onNewAnswer(user: User, answer: String) {
        let answer = Answer(id: user.id, username: user.username, answer: answer)
        self.answers.append(answer)
    }
    
    private func onNextRound() {
        //..
    }
    
    private func onEndSession() {
        //..
    }
}
