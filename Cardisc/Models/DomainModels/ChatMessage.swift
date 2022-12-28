//
//  ChatMessage.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/12/2022.
//

import Foundation

struct ChatMessage: Identifiable, Equatable {
    var id = UUID()
    let username: String?
    let message: String
}

