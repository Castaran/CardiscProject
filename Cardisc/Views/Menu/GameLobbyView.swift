
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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .frame(width: 38, height: 22)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 1)
                    Text("Game lobby (\(vm.lobby.sessionCode ?? "0000"))").font(.system(size: 20)).bold().foregroundColor(Color.white)
                    Spacer()
                    Image(systemName: "square.and.arrow.up").foregroundColor(Color.white).padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                PlayerList(players: vm.players)
                
                if(vm.isHost) {
                    HStack {
                        Picker("Number of cards", selection: $vm.rounds) {
                            ForEach(1 ..< 8) {
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
                    
                    HStack {
                        //SIBTAIN: can we change this to a not static form?
                        Picker(selection: $vm.duration, label: Text("Some Label")) {
                            Text("60 seconds").tag(60)
                            Text("120 seconds").tag(120)
                            Text("180 seconds").tag(180)
                        }.onChange(of: vm.duration) { tag in
                            vm.duration = tag
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
            .padding(.horizontal, 30)
            
            if(vm.isHost) {
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
            
            MenuItem(
                menuIcon: "person.crop.circle.badge.checkmark",
                iconHeight: 30,
                iconWidth: 35,
                menuTitle: "Ready/unready",
                menuColor: UIColor.systemBlue,
                menuPaddingRight: 30
            ).onTapGesture {
                vm.changeState()
            }
            
            NavigationLink("", destination: LoadingView(vm: vm, title: "Starting game", message: "Prepare to answer the first question.."), isActive: $vm.startedGame).onAppear{ vm.startedGame = false }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
        //SIBTAIN: is this a good location for an alert? or better in a seperate file?
        .navigationBarItems(leading: Button(action: { vm.showConfirmation.toggle()}) {
            Image(systemName: "chevron.left")
            Text("Leave session")
        }
            .alert(isPresented: $vm.showConfirmation) { Alert(
                    title: Text("Leaving current session"),
                    message: Text("Are you sure you want to leave this session?"),
                    primaryButton: .destructive(Text("Leave"))
                    {
                        vm.leaveGame()
                        dismiss()
                    }, secondaryButton: .cancel())})
        .background(Image("WP1").resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}
