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
        VStack {
            HStack {
                Text("Answers:").bold()
                Spacer()
            }
            
            Divider()
            
            ForEach(answers) { answer in
                PlayerAnswer(answer: answer)
            }
        }
        .padding(15)
        .shadow(radius: 5)
        .background(Color(UIColor.white))
        .cornerRadius(10, corners: [.allCorners])
        .padding(15)

    }
}
