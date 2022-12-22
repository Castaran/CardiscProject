//
//  registerDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 27/11/2022.
//

import Foundation

struct registerResponseDto: Codable {
    let username: String
    let password: String
    let email: String
}
