//
//  lobbyPlayerDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct lobbyResponseDto: Identifiable, Decodable {
    let id: String
    let hostId: String
    let sessionCode: String
    let created: String
    let sessionAuth: String
    let players: [lobbyPlayerDto]
    
    func toDomainModel() -> Lobby {
        var players: [LobbyPlayer] = []
        
        for p in self.players {
            players.append(p.toDomainModel())
        }
        
        let lobby = Lobby(
            id: self.id,
            hostId: self.hostId,
            sessionCode: self.sessionCode,
            created: self.created,
            sessionAuth: self.sessionAuth,
            players: players)
        
        return lobby
    }
}
