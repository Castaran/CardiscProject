
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
    @State private var showConfirmation = false
    @Environment(\.dismiss) var dismiss
    
    let isHost: Bool
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .frame(width: 38, height: 22)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 1)
                    Text("Game lobby (\(vm.lobby?.sessionCode ?? "0000"))").font(.system(size: 20)).bold().foregroundColor(Color.white)
                    Spacer()
                    Image(systemName: "square.and.arrow.up").foregroundColor(Color.white).padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                PlayerList(players: vm.players)
                
                HStack {
                    Picker("Number of cards", selection: $vm.rounds) {
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
                
                HStack {
                    //change this from static to some list in vm
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
            .padding(.horizontal, 30)
            
            NavigationLink("", destination: CardView(vm: vm), isActive: $vm.gameInProgress)
            
            MenuItem(
                menuIcon: "play.fill",
                iconHeight: 25,
                iconWidth: 25,
                menuTitle: "Start game",
                menuColor: UIColor.systemGreen,
                menuPaddingRight: 30
            ).onTapGesture {
                vm.startGame(rounds: vm.rounds, duration: vm.duration)
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.showConfirmation.toggle()}) {
            Image(systemName: "chevron.left")
            Text("Leave session")
        }
            .alert(isPresented: $showConfirmation) { Alert(
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
