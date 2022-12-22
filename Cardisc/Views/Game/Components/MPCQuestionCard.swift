//
//  CardItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation
import SwiftUI

struct MPCQuestionCard : View {
    @State private var answer: Int = 0
    
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
                Text("Pick an answer:")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.top, 15)
            
            VStack {
                HStack {
                    Text("A:").font(.system(size: 24)).bold()
                    Text("This is the first answer.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(UIColor.systemBlue))
                .cornerRadius(30)
                
                HStack {
                    Text("B:").font(.system(size: 24)).bold()
                    Text("This is the second answer.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(UIColor.white))
                .foregroundColor(Color(UIColor.systemBlue))
                .cornerRadius(30)
                
                HStack {
                    Text("C:").font(.system(size: 24)).bold()
                    Text("This is the third answer.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(UIColor.white))
                .foregroundColor(Color(UIColor.systemBlue))
                .cornerRadius(30)
                
                HStack {
                    Text("D:").font(.system(size: 24)).bold()
                    Text("This is the fourth answer.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(UIColor.white))
                .foregroundColor(Color(UIColor.systemBlue))
                .cornerRadius(30)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundColor(Color.white)
            
            
            
            
            Spacer().frame(height: 20)
        }
        .padding(10)
        .border(Color(UIColor.black), width: 5)
        .background(Color(UIColor.systemGray3))
        .padding(25)
    }
}

struct MPCQuestionCard_Preview: PreviewProvider {
    static var previews: some View {
        MPCQuestionCard()
    }
}
