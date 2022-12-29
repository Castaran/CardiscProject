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
    
    func toDomainModel() -> Game {
        var cards: [Card] = []
        
        for c in self.cards {
            let card = c.toDomainModel()
            cards.append(card)
        }
        
        return Game(cards: cards, roundDuration: self.roundDuration)
    }
}
