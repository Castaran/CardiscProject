//
//  ExitView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/12/2022.
//

import Foundation
import SwiftUI

struct ExitView: View {
    @ObservedObject var vm: GameViewModel
    
    let isHost = true
    
    var body: some View {
        NavigationLink("", destination: CardView(vm: vm), isActive: $vm.nextView).onAppear{ vm.nextView = false }
        
        VStack {
            HStack {
                Image(systemName: "hourglass.tophalf.filled").resizable().foregroundColor(Color.white).frame(width: 25, height: 30)
                Text("Game finished").font(.system(size: 28)).foregroundColor(Color.white).bold()
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 30)
            
            VStack {
                HStack {
                    Text("Thanks for playing this game!")
                }
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                if(!isHost) {
                    HStack {
                        Text("Please let us know what you learned from this game, this would really help us.")
                    }
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
            }
            
            if(!isHost) {
                VStack {
                    TextField(
                        "...",
                        text: $vm.conclusion
                    )
                    .padding(.top, 10)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(15, corners: [.allCorners])
                    .padding(.horizontal, 30)
                    .shadow(radius: 10)
                }
                MenuItem(menuIcon: "play.fill", iconHeight: 20, iconWidth: 18, menuTitle: "Continue", menuColor: UIColor.systemBlue, menuPaddingRight: 10).onTapGesture {
                    vm.nextRound()
                }
            }
        }
        //SIBTAIN: I would like to have a full screen background on (almost) every view in the form of an image. Is this the best way to do that?
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 30)
        .background(Image("WP2")
            .resizable()
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+70)
        )
        .navigationBarHidden(true)
    }
}

