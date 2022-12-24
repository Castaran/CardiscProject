//
//  PlayerAnswer.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 24/12/2022.
//

import Foundation
import SwiftUI

struct PlayerAnswer: View {
    var answer: Answer
    
    var body: some View {
        HStack {
            Text(answer.username)
            Spacer()
            Text(answer.answer)
        }
    }
}
