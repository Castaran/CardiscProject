//
//  userDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct userDto: Codable {
    let id: String
    let username: String
    let email: String
    let picture: String
}
