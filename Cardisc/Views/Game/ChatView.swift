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
    var isHost = true
    
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
                
                NavigationLink("", destination: NavigationLazyView(MainMenuView()), isActive: $vm.finishedGame).onAppear { vm.nextView = false }
                
                if(isHost) {
                    NavigationLink {
                        ConclusionView(vm: vm)
                    } label: {
                        MenuItem(menuIcon: "arrowtriangle.right.fill", iconHeight: 20, iconWidth: 18, menuTitle: "Play next card", menuColor: UIColor.systemBlue, menuPaddingRight: 10)
                    }
                    
                }
                else {
                    MenuItem(menuIcon: "hourglass.tophalf.filled", iconHeight: 26, iconWidth: 18, menuTitle: "Vote continue", menuColor: UIColor.systemBlue, menuPaddingRight: 10)
                }
            }
            
            VStack {
                HStack {
                    Text("Answers:").bold()
                    Spacer()
                }
                
                Divider()
                
                PlayerAnswerList(answers: vm.answers)
                
                VStack {
                    Image(systemName: "chevron.down")
                }.onTapGesture {
                    
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(15)
            .shadow(radius: 5)
            .background(Color(UIColor.white))
            .cornerRadius(10, corners: [.allCorners])
            .padding(15)
            
            
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
            .background(Color(UIColor.systemGray5))
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Image("WP1")
            .resizable()
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+30)
            .brightness(-0.08)
        )
        .navigationBarHidden(true)
    }
}
