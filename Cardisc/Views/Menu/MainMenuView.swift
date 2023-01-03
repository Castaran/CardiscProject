//
//  MainMenu.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    @ObservedObject var vm = MainMenuViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Logo()
                
                Spacer().frame(height: 70)
                
                NavigationLink {
                    NavigationLazyView(JoinGameView(vm: vm.gameViewModel))
                } label: {
                    MenuItem(
                        menuIcon: "person.2.fill",
                        iconHeight: 22,
                        iconWidth: 36,
                        menuTitle: "Join a game",
                        menuColor: UIColor.systemBlue,
                        menuPaddingRight: 74)
                }
                
                MenuItem(
                    menuIcon: "crown.fill",
                    iconHeight: 24,
                    iconWidth: 34,
                    menuTitle: "Host a game",
                    menuColor: UIColor.systemBlue,
                    menuPaddingRight: 68,
                    isLoading: vm.hostGameIsLoading
                ).onTapGesture {
                    self.vm.hostGame()
                }
                
                NavigationLink {
                    HowToPlayView()
                } label: {
                    MenuItem(
                        menuIcon: "questionmark.circle.fill",
                        iconHeight: 26,
                        iconWidth: 26,
                        menuTitle: "How-to-play",
                        menuColor: UIColor.systemBlue,
                        menuPaddingRight: 77)
                }
                
                Spacer().frame(height: 50)
                
                NavigationLink {
                    NavigationLazyView(AccountSettingsView())
                } label: {
                    MenuItem(menuIcon: "gearshape.fill", iconHeight: 26, iconWidth: 26, menuTitle: "Account settings", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
                }
                
                MenuItem(menuIcon: "arrowshape.turn.up.left.fill", iconHeight: 24, iconWidth: 30, menuTitle: "Logoff", menuColor: UIColor.systemRed, menuPaddingRight: 40, isLoading: vm.logOffIsLoading).onTapGesture {
                    vm.logOff()
                }
            }
            .navigationBarHidden(true)
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationDestination(isPresented: $vm.hostSucceed) {
                NavigationLazyView(GameLobbyView(vm: vm.gameViewModel))
            }
            .navigationDestination(isPresented: $vm.hostSucceed) { NavigationLazyView(GameLobbyView(vm: vm.gameViewModel)) }
            .navigationDestination(isPresented: $vm.isLoggedOff) { StartView() }
        }
        .backgroundImage()
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}



