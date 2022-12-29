//
//  CardItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation
import SwiftUI

struct OpenQuestionCard : View {
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Question \(vm.gameIndex)").foregroundColor(Color.black).bold().font(.system(size: 20))
                Spacer()
                Text("Round \(vm.gameIndex)/\(vm.rounds)")
            }
            .padding(10)
            HStack {
                Text(vm.currentCard.body).foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(20, corners: [.allCorners])
        .padding(.horizontal, 30)
        .shadow(radius: 10)
        
        VStack {
            TextField(
                "Your answer...",
                text: $vm.answer
            )
            .padding(.top, 10)
            .padding(.bottom, 20)
            .padding(.horizontal, 15)
            .background(Color.white)
            .cornerRadius(15, corners: [.allCorners])
            .padding(.horizontal, 30)
            .shadow(radius: 10)
        }
        
        MenuItem(menuIcon: "play.fill", iconHeight: 22, iconWidth: 22, menuTitle: "Play card", menuColor: UIColor.systemBlue, menuPaddingRight: 40).onTapGesture {
            vm.submitAnswer()
        }
        .navigationDestination(isPresented: $vm.submittedAnswer) { ChatView(vm: vm) }
    }
}

