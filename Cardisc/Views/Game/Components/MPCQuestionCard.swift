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
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Question \(vm.currentCard.number)").foregroundColor(Color.black).bold().font(.system(size: 20))
                Spacer()
            }
            
            HStack {
                Text(vm.currentCard.body).foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 5)
            
            HStack {
                Text("Pick an answer: \(vm.answer)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 15)
            
            VStack {
                HStack {
                    MPCButton(buttonBody: "A", color: UIColor.systemRed).onTapGesture { vm.answer = "A" }
                    MPCButton(buttonBody: "B", color: UIColor.systemBlue).onTapGesture { vm.answer = "B" }
                }
                HStack {
                    MPCButton(buttonBody: "C", color: UIColor.systemYellow).onTapGesture { vm.answer = "C" }
                    MPCButton(buttonBody: "D", color: UIColor.systemGreen).onTapGesture { vm.answer = "D" }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20, corners: [.allCorners])
        .padding(.horizontal, 30)
        .shadow(radius: 10)
        
        VStack {
            NavigationLink {
                ChatView(vm: vm)
            } label: {
                HStack {
                    MenuItem(menuIcon: "play.fill", iconHeight: 22, iconWidth: 22, menuTitle: "Play card", menuColor: UIColor.systemBlue, menuPaddingRight: 40).onTapGesture {
                        vm.submitAnswer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        }
    }
}
