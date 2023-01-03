//
//  PlayerAnswer.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 24/12/2022.
//

import Foundation
import SwiftUI

struct PlayerAnswerOpen: View {
    @State var answer: Answer
    
    var body: some View {
        VStack {
            HStack {
                Text("\(answer.username)").bold()
                Spacer()
            }
            HStack {
                Text("\(answer.answer)").foregroundColor(Color.black)
                Spacer()
            }
        }
    }
}

struct PlayerAnswerOpen_Preview: PreviewProvider {
    static var previews: some View {
        PlayerAnswerOpen(answer: Answer(id: "123", username: "Tim", answer: "Banaanajkdkafhlskdhflkasjhdflkjashdflkjsahdflksajhdlfkahjlksh"))
    }
}
