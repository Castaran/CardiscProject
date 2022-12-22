//
//  loginResponseDto.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation

struct loginResponseDto: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let user: userDto
}
