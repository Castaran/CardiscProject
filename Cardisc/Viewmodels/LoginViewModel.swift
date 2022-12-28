//
//  LoginViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    private let accountManager = AccountManager()
    
    @Published var username: String = ""
    @Published var usernameFieldColor = UIColor.black
    @Published var password: String = ""
    @Published var passwordFieldColor = UIColor.black
    @Published var loggedIn: Bool = false
    @Published var isRequestInProgress: Bool = false
    @Published var errorMessage: String = ""
    
    func loginUser() {
        self.isRequestInProgress = true
        DispatchQueue.main.async {
            if(!self.username.isEmpty) {
                if(!self.password.isEmpty) {
                    self.accountManager.loginUser(username: self.username, password: self.password) { data in
                        self.isRequestInProgress = false
                        self.loggedIn = true
                        self.errorMessage = ""
                    }
                }
                else {
                    self.errorMessage = "Passwordfield is empty!"
                    self.isRequestInProgress = false
                }
            }
            else {
                self.errorMessage = "Usernamefield is empty!"
                self.isRequestInProgress = false
            }

        }
    }
}
