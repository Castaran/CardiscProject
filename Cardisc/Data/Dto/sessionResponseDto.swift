//
//  sessionResponseDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct sessionResponseDto: Codable {
    let id: String
    let cardNumber: Int
    let user: userDto
    let response: String
    let createdAt: String
}
