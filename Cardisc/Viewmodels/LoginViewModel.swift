//
//  LoginViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let accountManager = AccountManager()
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isActive: Bool = false
    @Published var isRequestInProgress: Bool = false
    
    func loginUser(username: String, password: String) {
        DispatchQueue.main.async {
            self.accountManager.loginUser(username: username, password: password) { data in
                self.isActive = true
            }
        }
        
    }
}
