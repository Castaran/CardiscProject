//
//  lobbyPlayerDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct lobbyPlayerDto: Identifiable, Decodable {
    var ready: Bool
    let id: String
    var username: String
    let email: String
    let role: String
    let picture: String

}


