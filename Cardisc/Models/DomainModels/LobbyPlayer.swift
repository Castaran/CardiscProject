//
//  LobbyPlayer.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 10/12/2022.
//

import Foundation

struct LobbyPlayer: Codable, Identifiable {
    var ready: Bool
    let id: String
    let username: String
    let email: String
    let role: String
    let picture: String
}
