//
//  SignalR.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 04/12/2022.
//

import Foundation
import SignalRClient
import Combine
import SwiftUI

class SignalRService: ObservableObject {
    //SignalR variables
    private let defaults = UserDefaults.standard
    private var connection: HubConnection
    private var apiService = ApiService()
    private var connectionId = ""
    
    //Game variables, these change on the actions of any user in the session
    @Published var players: [LobbyPlayer] = []
    @Published var gameIndex: Int = 0
    @Published var game: Game = Game(cards: [], roundDuration: 0)
    @Published var currentCard: Card = Card(id: "", number: 0, name: "", body: "", type: 0)
    @Published var answers: [Answer] = []
    @Published var chatMessages: [ChatMessage] = []
    @Published var startedGame: Bool = false
    
    public init() {
        self.connection = HubConnectionBuilder(url: URL(string: Constants.SIGNALR_BASE_URL + defaults.string(forKey: "X-AUTHTOKEN")!)!)
            .withLogging(minLogLevel: .error)
            .build()
        
        connection.on(method: "newConnection", callback: {
            (id: String) in
            print("NEW CONNECTION ACTION PERFORMED")
            self.connectionId = id
        })
        
        connection.on(method: "readyStateChanged", callback: {
            (player: lobbyPlayerDto) in
            print("READY STATE CHANGE ACTION PERFORMED")
            self.onReadyStateChange(player: player.toDomainModel())
        })
        
        connection.on(method: "newPlayer", callback: {
            (player: lobbyPlayerDto) in
            print("NEW PLAYER IN THE ROOM")
            self.onNewPlayer(player: player.toDomainModel())
        })
        
        connection.on(method: "playerLeft", callback: {
            (player: playerLeftDto) in
            print("PLAYER LEFT ACTION PERFORMED")
            self.onPlayerLeft(player: player)
        })
        
        connection.on(method: "startGame", callback: {
            (game: startGameDto) in
            print("START GAME ACTION PERFORMED \(game.cards.count) + \(game.roundDuration)")
            self.onGameStarted(game: game.toDomainModel())
        })
        
        connection.on(method: "newMessage", callback: {
            (user: userDto, cardIndex: Int, message: String) in
            print("NEW MESSAGE ACTION PERFORMED")
            self.onNewMessage(user: user.toDomainModel(), cardIndex: cardIndex, message: message)
        })
        
        connection.on(method: "newAnswer", callback: {
            (user: userDto, answer: String) in
            print("NEW ANSWER ACTION PERFORMED")
            self.onNewAnswer(user: user.toDomainModel(), answer: answer)
        })
        
        connection.on(method: "nextRound", callback: {
            print("NEXT ROUND ACTION PERFORMED")
            self.onNextRound()
        })
        
        connection.on(method: "endSession", callback: {
            print("END SESSION ACTION PERFORMED")
            //TODO: @TIM add method for ending a session/game
        })
        
        connection.on(method: "close", callback: {
            print("CONN CLOSED")
        })
        connection.start()
    }
    
    
    public func joinMessageGroup() {
        let body: [String: AnyHashable] = [
            "connectionId": self.connectionId,
        ]

        apiService.httpRequestWithoutReturn(body: body, url: Constants.API_BASE_URL + "joinGrp", httpMethod: "POST")
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
        if(!players.contains(where: { $0.username == player.username })) {
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
        self.startedGame = true
    }
    
    private func onNewMessage(user: User, cardIndex: Int, message: String) {
        if(!chatMessages.contains(where: { $0.message == message })) {
            self.chatMessages.append(ChatMessage(username: user.username, message: message))
        }
    }
    
    private func onNewAnswer(user: User, answer: String) {
        self.answers.append(Answer(id: user.id, username: user.username, answer: answer))
    }
    
    private func onNextRound() {
        self.gameIndex += 1
        if(game.cards.count > self.gameIndex) {
            self.currentCard = game.cards[self.gameIndex]
            self.chatMessages = []
            self.answers = []
        }
        else {
            self.game = Game(cards: [], roundDuration: 0)
            self.currentCard = Card(id: "", number: 0, name: "", body: "", type: 0)
            print("Game done")
        }
    }
    
    private func onEndSession() {
        //TODO: ...
    }
}
