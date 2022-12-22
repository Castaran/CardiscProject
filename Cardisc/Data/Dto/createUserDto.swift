//
//  createUserDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct createUserDto: Codable {
    let username: String
    let password: String
    let email: String
}
