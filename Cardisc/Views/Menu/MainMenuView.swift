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
                
                Spacer().frame(height: 70)
                
                NavigationLink("", destination: NavigationLazyView(GameLobbyView(vm: vm.gameViewModel)), isActive: $vm.hostSucceed)
                NavigationLink("", destination: NavigationLazyView(StartView()), isActive: $vm.isLoggedOff)
                
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
                
                MenuItem(menuIcon: "crown.fill", iconHeight: 24, iconWidth: 36, menuTitle: "Host a game", menuColor: UIColor.systemBlue, menuPaddingRight: 68, isLoading: false).onTapGesture {
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
            .fullScreenCover(isPresented: $vm.showLoadingScreen) {
                LoadingView(vm: vm.gameViewModel, title: "Starting game", message: "Prepare to answer the first question..")
            }
        }
        .backgroundImage()
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}


struct BackgroundImage: ViewModifier {
    
    var imageName: String
    
    func body(content: Content) -> some View {
        content
            .background(Image(imageName).resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
        
    }
}


extension View {
    
    func backgroundImage(imageName: String = "WP1") -> some View {
        modifier(BackgroundImage(imageName: imageName))
    }
    
}
