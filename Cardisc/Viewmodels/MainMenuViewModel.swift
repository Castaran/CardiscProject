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
    
    //Loading states
    @Published var isLoadingHostGame: Bool = false
    
    @Published var hostGameIsLoading: Bool = false
    @Published var hostSucceed: Bool = false
    @Published var logOffIsLoading: Bool = false
    @Published var isLoggedOff: Bool = false
    
    func logOff() {
        self.logOffIsLoading = true
        self.userManager.logoffUser()
        self.isLoggedOff = true
        self.logOffIsLoading = false
    }
    
    func hostGame() {
        self.hostGameIsLoading = true
        gameViewModel.createGame {
            DispatchQueue.main.async {
                self.hostGameIsLoading = false
                self.hostSucceed = true
            }
        }
    }
}
