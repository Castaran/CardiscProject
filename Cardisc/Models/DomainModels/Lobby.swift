//
//  Lobby.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 10/12/2022.
//

import Foundation

struct Lobby: Codable {
    let id: String
    let hostId: String
    let sessionCode: String
    let created: String
    let sessionAuth: String
    let players: [LobbyPlayer]
}
