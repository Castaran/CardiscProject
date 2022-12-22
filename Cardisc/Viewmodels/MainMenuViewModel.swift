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
    
    func logOff() {
        self.logOffIsLoading = true
        userManager.logoffUser()
        self.isLoggedOff = true
        self.logOffIsLoading = false
    }
    
    func hostGame() -> GameViewModel {
        DispatchQueue.main.async {
            self.gameViewModel.createGame()
            self.hostSucceed = true
        }
        return self.gameViewModel
    }
}
