//
//  playerLeftDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 23/12/2022.
//

import Foundation

struct playerLeftDto: Codable {
    let name: String
    let email: String
    let password: String
    let ready: Bool
    let picture: String
}
