
//
//  GameLobbyView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct GameLobbyView: View {
    @StateObject var vm: GameViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let isHost: Bool
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("WP1")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        VStack{
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .resizable()
                                    .frame(width: 38, height: 22)
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 1)
                                Text("Game lobby (\(vm.lobbyResponseDto?.sessionCode ?? "0000"))").font(.system(size: 20)).bold().foregroundColor(Color.white)
                                Spacer()
                                Image(systemName: "square.and.arrow.up").foregroundColor(Color.white).padding(.trailing, 20)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            PlayerList(players: vm.players)
                            
                            
                            if(isHost) {
                                HStack {
                                    Picker("Number of cards", selection: $vm.amountSelected) {
                                        ForEach(1 ..< 10) {
                                            Text("\($0) round(s)")
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 50)
                                    .background(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(25, corners: [.allCorners])
                                }
                                .background(Color.white)
                                .cornerRadius(10, corners: [.allCorners])
                                .shadow(radius: 5)
                                .padding(.bottom, 10)
                            }
                        }
                        .padding(.horizontal, 35)
                        
                        if(isHost) {
                            MenuItem(
                                menuIcon: "play.fill",
                                iconHeight: 25,
                                iconWidth: 25,
                                menuTitle: "Start game",
                                menuColor: UIColor.systemGreen,
                                menuPaddingRight: 30
                            ).onTapGesture {
                                vm.startGame()
                            }
                        }
                        else {
                            MenuItem(
                                menuIcon: "person.crop.circle.badge.checkmark",
                                iconHeight: 30,
                                iconWidth: 35,
                                menuTitle: "Ready/unready",
                                menuColor: UIColor.systemGreen,
                                menuPaddingRight: 30
                            ).onTapGesture {
                                vm.changeState()
                            }
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 30)
                }
            }
        }

        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            vm.leaveGame()
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack {
                Image(systemName: "chevron.backward")
                Text("Leave session").foregroundColor(Color(UIColor.systemBlue))
            }
            
            
        })
    }
}
