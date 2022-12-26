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
    
    func toDomainModel() -> User {
        return User(id: self.id, username: self.username, email: self.email, picture: self.picture)
    }
}
