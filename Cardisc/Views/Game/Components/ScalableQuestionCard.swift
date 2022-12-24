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
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Question 3").foregroundColor(Color.black).bold().font(.system(size: 20))
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(vm.currentCard.body).foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("**Score:** \(Int(answer))")
                Slider(value: $answer, in: 1...10, step: 1) { value in
                    vm.answer = String(answer)
                }.padding(.horizontal, 10)
                HStack {
                    Text("Agree")
                    Spacer()
                    Text("Disagree")
                }
            }
            .padding(.top, 50)
        }
        .padding(25)
        .background(Color.white)
        .cornerRadius(20, corners: [.allCorners])
        .padding(.horizontal, 30)
        .shadow(radius: 10)
        
        NavigationLink("", destination: ChatView(vm: vm), isActive: $vm.nextView)
        MenuItem(menuIcon: "play.fill", iconHeight: 22, iconWidth: 22, menuTitle: "Play card", menuColor: UIColor.systemBlue, menuPaddingRight: 40).onTapGesture {
            vm.submitAnswer()
        }
    }
}

