//
//  cardDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct cardDto: Codable {
    let id: String
    let cardNumber: Int
    let cardName: String
    let cardBody: String
    let type: Int
    
    func toDomainModel() -> Card {
        print("\(self.cardBody): \(self.type)")
        return Card(
            id: self.id,
            number: self.cardNumber,
            name: self.cardName,
            body: self.cardBody,
            type: self.type)
    }
}
