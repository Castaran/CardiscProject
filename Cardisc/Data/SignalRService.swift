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
            (player: lobbyPlayerDto) in
            print("PLAYER LEFT ACTION PERFORMED")
            
        })
        
        connection.on(method: "startGame", callback: {
            print("START GAME ACTION PERFORMED")
            //Method te perform
        })
        
        connection.on(method: "newMessage", callback: {
            print("NEW MESSAGE ACTION PERFORMED")
            //Method te perform
        })
        
        connection.on(method: "newAnswer", callback: {
            print("NEW ANSWER ACTION PERFORMED")
            //Method te perform
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
    
    private func onPlayerLeft(player: lobbyPlayerDto) {
        var index = 0
        for p in self.players {
            if(p.username == player.username) {
                self.players.remove(at: index)
                print("Player removed from session: \(p.username)")
                index+=1
            }
        }
    }
    
    private func onGameStarted(gameInfo: String) {
        //..
    }
    
    private func onNewMessage(user: userDto, cardIndex: Int, message: String) {
        //..
    }
    
    private func onNewAnswer(user: userDto, answer: submitAnswerDto) {
        //..
    }
    
    private func onNextRound() {
        //..
    }
    
    private func onEndSession() {
        //..
    }
}
