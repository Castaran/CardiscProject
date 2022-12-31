//
//  ConclussionView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct ConclusionView: View {
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "highlighter").resizable().foregroundColor(Color.white).frame(width: 25, height: 30)
                Text("Conclusion (optional)").font(.system(size: 28)).foregroundColor(Color.white).bold()
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 30)
            
            HStack {
                Text("Add a conclussion to the conversation in the previous view")
            }
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            
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
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 40)
        .backgroundImage(imageName: "WP3")
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.finishedGame) { NavigationLazyView(MainMenuView()) }
        .navigationDestination(isPresented: $vm.nextRoundStarted) { CardView(vm: vm) }
        .fullScreenCover(isPresented: $vm.isLoadingMainMenu) {
            LoadingView(title: "Game finished", message: "The gamehost thanks you for playing this game!", icon: "flag.2.crossed.fill", iconWidth: 45)
        }
    }
}
