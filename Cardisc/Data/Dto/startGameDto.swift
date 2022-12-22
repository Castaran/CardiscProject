//
//  startGameDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct startGameDto: Codable {
    let cards: [cardDto]
    let roundDuration: Int
}
