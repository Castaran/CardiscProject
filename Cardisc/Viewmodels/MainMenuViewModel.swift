//
//  MainMenuViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 09/12/2022.
//

import Foundation

class MainMenuViewModel: ObservableObject {
    private let userManager = UserManager()
    @Published var gameViewModel = GameViewModel()
    
    @Published var hostGameIsLoading: Bool = false
    @Published var hostSucceed: Bool = false
    @Published var logOffIsLoading: Bool = false
    @Published var isLoggedOff: Bool = false
    @Published var showLoadingScreen: Bool = false
    
    func logOff() {
        self.logOffIsLoading = true
        userManager.logoffUser()
        self.isLoggedOff = true
        self.logOffIsLoading = false
    }
    
    func hostGame() {
        showLoadingScreen = true
        gameViewModel.createGame {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.showLoadingScreen = false
                self.hostSucceed = true
            }
        }
    }
}
