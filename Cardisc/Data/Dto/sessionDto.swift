//
//  sessionDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct sessionDto: Codable {
    let id: String
    let created: String
    let sessionCode: String
    let platers: [userDto]
    let status: String
    let cards: [cardDto]
    let responses: [sessionResponseDto]
}
