//
//  PlayerAnswerList.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 24/12/2022.
//

import Foundation
import SwiftUI

struct PlayerAnswerList: View {
    
    var answers: [Answer]
    
    var body: some View {
        ForEach(answers) { answer in
            PlayerAnswer(answer: answer)
        }
    }
}
