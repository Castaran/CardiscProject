//
//  CardItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation
import SwiftUI

struct OpenQuestionCard : View {
    @State private var answer: String = ""
    
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
            .padding(.horizontal, 10)
            
            HStack {
                Text("Enther your answer bellow:")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.top, 15)
            
            TextField(
                "",
                text: $answer
            )
            .padding(.vertical, 120)
            .padding(.horizontal, 15)
            .background(Color.white)
            .cornerRadius(5)
            .padding(20)
            
            Spacer().frame(height: 20)
        }
        .padding(10)
        .border(Color(UIColor.black), width: 5)
        .background(Color(UIColor.systemGray3))
        .padding(25)
    }
}

struct OpenQuestionCard_Preview: PreviewProvider {
    static var previews: some View {
        OpenQuestionCard()
    }
}
