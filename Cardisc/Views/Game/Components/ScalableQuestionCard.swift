//
//  CardItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation
import SwiftUI

struct ScalableQuestionCard : View {
    @State private var answer: Double = 1
    
    var body: some View {
        VStack {
            HStack {
                Text("Question 1").foregroundColor(Color.black).bold().font(.system(size: 20))
                Spacer()
                Text("Round 1/3").foregroundColor(Color.black).opacity(0.5)
            }
            .padding(10)
            HStack {
                Text("What fruit type is most innovative?").foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            
            VStack {
                Text("**Score:** \(Int(answer))")
                Slider(value: $answer, in: 1...10, step: 1).padding(.horizontal, 10)
                HStack {
                    Text("Agree")
                    Spacer()
                    Text("Disagree")
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 100)
        }
        .padding(10)
        .border(Color(UIColor.black), width: 5)
        .background(Color(UIColor.systemGray3))
        .padding(25)
        
    }
}

struct ScalableQuestionCard_Preview: PreviewProvider {
    static var previews: some View {
        ScalableQuestionCard()
    }
}
