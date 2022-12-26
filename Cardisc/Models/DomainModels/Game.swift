//
//  Game.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 23/12/2022.
//

import Foundation

struct Game: Codable {
    let cards: [Card]
    let roundDuration: Int
}
