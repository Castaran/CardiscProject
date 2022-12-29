//
//  JoinGame.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct JoinGameView: View {
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .frame(width: 36, height: 22)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 5)
                    Text("Join a game").font(.system(size: 24)).foregroundColor(Color.white).bold()
                    Spacer()
                }
                
                HStack {
                    Text("Join a game by entering the Game ID you received from the game host.").foregroundColor(Color.white)
                    Spacer()
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            VStack{
                HStack {
                    Text("Enter game id.").foregroundColor(Color(UIColor.white)).bold()
                    Spacer()
                }
                .padding(.top, 20)
                
                HStack {
                    TextField(
                        "...",
                        text: $vm.gameId
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                
            }.padding(.horizontal, 30)
            HStack {
                
            }
            .padding(.top, 40)
            
            MenuItem(
                menuIcon: "person.wave.2.fill",
                iconHeight: 24,
                iconWidth: 30,
                menuTitle: "Join Game",
                menuColor: UIColor.systemBlue,
                menuPaddingRight: 40,
                isLoading: vm.isLoadingJoinSession
            ).onTapGesture {
                self.vm.joinGame()
            }
            
            Spacer()
        }
        .backgroundImage()
        .navigationDestination(isPresented: $vm.joinedGame) { GameLobbyView(vm: vm) }
    }
}

