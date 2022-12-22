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
}
