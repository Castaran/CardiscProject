//
//  MainMenu.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    private let vm = UserViewModel()
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Logo
                HStack {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 70, height: 70)
                        VStack (
                            alignment: .leading
                        ) {
                            Text("Cardisc").font(.system(size: 32)).bold()
                            Text("An idea developing tool").font(.system(size: 18))
                        }
                    }
                    .padding(.vertical, 35)
                    .padding(.leading, 10)
                    .padding(.trailing, 20)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
                    .shadow(radius: 8)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 80)
                
                NavigationLink {
                    JoinGameView()
                } label: {
                    HStack {
                        MenuItem(menuIcon: "person.2.fill", iconHeight: 22, iconWidth: 36, menuTitle: "Join a game", menuColor: UIColor.systemBlue, menuPaddingRight: 74)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                NavigationLink {
                    GameLobbyView()
                } label: {
                    HStack {
                        MenuItem(menuIcon: "crown.fill", iconHeight: 26, iconWidth: 36, menuTitle: "Host a game", menuColor: UIColor.systemBlue, menuPaddingRight: 69)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                NavigationLink {
                    HowToPlayView()
                } label: {
                    HStack {
                        MenuItem(menuIcon: "questionmark.circle.fill", iconHeight: 26, iconWidth: 26, menuTitle: "How-to-play", menuColor: UIColor.systemBlue, menuPaddingRight: 77)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Spacer().frame(height: 50)
                
                NavigationLink {
                    AccountSettingsView()
                } label: {
                    HStack {
                        MenuItem(menuIcon: "gearshape.fill", iconHeight: 26, iconWidth: 26, menuTitle: "Account settings", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                NavigationLink("", destination: StartView(), isActive: $isActive)
                MenuItem(menuIcon: "arrowshape.turn.up.left.fill", iconHeight: 24, iconWidth: 30, menuTitle: "Logoff", menuColor: UIColor.systemRed, menuPaddingRight: 40).onTapGesture {
                    vm.logoffUser()
                    isActive = true
                }
                
                
                
                
            }
            .navigationBarHidden(true)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Image("WP1")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+70)
                .brightness(-0.08)
            )
        }
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
