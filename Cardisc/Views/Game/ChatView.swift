//
//  MainMenu.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct ChatView: View {
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .foregroundColor(Color.white)
                    Text("Chat")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24))
                }
                .padding(.horizontal,30)
                .padding(.vertical,30)
                
                Spacer()
                
                if(vm.isHost) {
                    NavigationLink {
                        ConclusionView(vm: vm)
                    } label: {
                        MenuItem(menuIcon: "arrowtriangle.right.fill", iconHeight: 20, iconWidth: 18, menuTitle: "Continue", menuColor: UIColor.systemBlue, menuPaddingRight: 10)
                    }
                }
                else {
                    MenuItem(menuIcon: "hourglass.tophalf.filled", iconHeight: 26, iconWidth: 18, menuTitle: "Vote continue", menuColor: UIColor.systemBlue, menuPaddingRight: 10)
                }
            }
            
            //TODO: Dit even ergens anders neerzetten
            PlayerAnswerList(answers: vm.answers)
            
            ChatMessageList(chatMessages: $vm.chatMessages)

            HStack {
                TextField(
                    "...",
                    text: $vm.chatMessage
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(25)
                .shadow(radius: 0.5)
                .padding(.vertical, 15)
                .padding(.leading, 10)
                
                Image(systemName: "paperplane.circle.fill").resizable().frame(width: 35, height: 35).padding(.trailing, 10).foregroundColor(Color(UIColor.systemBlue)).onTapGesture {
                    vm.sendChatMessage()
                }
            }
            .padding(.bottom, 20)
            .background(Color(UIColor.systemGray5))
            Spacer()
        }
        .backgroundImage(imageName: "WP3")
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.nextRoundStarted) { CardView(vm: vm) }
        .navigationDestination(isPresented: $vm.finishedGame) { ExitView(vm: vm) }
    }
}
