//
//  lobbyPlayerDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct lobbyPlayerDto: Identifiable, Decodable {
    let ready: Bool
    let id: String
    let username: String
    let email: String
    let role: String
    let picture: String

    func toDomainModel() -> LobbyPlayer {
        return LobbyPlayer(
            ready: self.ready,
            id: self.id,
            username: self.username,
            email: self.email,
            role: self.role,
            picture: self.picture)
    }
}


