//
//  CardItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/11/2022.
//

import Foundation
import SwiftUI

struct OpenQuestionCard : View {
    @StateObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(vm.currentCard.name)").foregroundColor(Color.black).bold().font(.system(size: 20))
                    Spacer()
                    Text("Round \(vm.gameIndex+1)/\(vm.game.cards.count)")
                }
                .padding(.vertical, 10)
                
                HStack {
                    Text(vm.currentCard.body).foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.bottom, 10)
            }
            .foregroundColor(Color.black)
            .padding(.top, 10)
            .padding(.bottom, 20)
            .padding(.horizontal, 15)
            .background(Color.white)
            .cornerRadius(20, corners: [.allCorners])
            
            CardiscTextfield(value: $vm.answer, label: "Your answer:")
        }
        .padding(.horizontal, 30)
        .shadow(radius: 10)
        
        MenuItem(menuIcon: "play.fill", iconHeight: 22, iconWidth: 22, menuTitle: "Play card", menuColor: UIColor.systemBlue, menuPaddingRight: 40).onTapGesture {
            vm.submitAnswer()
        }
        .navigationDestination(isPresented: $vm.submittedAnswer) { ChatView(vm: vm) }
    }
}

