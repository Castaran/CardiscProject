//
//  Card.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 23/12/2022.
//

import Foundation

struct Card: Codable {
    let id: String
    let number: Int
    let name: String
    let body: String
    let type: Int
}
