//
//  RegisterViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 10/12/2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    private let accountManager = AccountManager()
    
    @Published var username: String = ""
    @Published var emailaddress: String = ""
    @Published var password: String = ""
    @Published var passwordRepeated: String = ""
    @Published var userRegistered: Bool = false
    @Published var errorMsg: String = ""
    
    func registerUser() {
        DispatchQueue.main.async {
            if(!self.username.isEmpty && !self.emailaddress.isEmpty && !self.password.isEmpty && !self.passwordRepeated.isEmpty) {
                if(self.password == self.passwordRepeated) {
                    self.accountManager.registerUser(username: self.username, password: self.password, emailadress: self.emailaddress) { data in
                        if (data != nil) {
                            self.userRegistered = true
                            print("\(data!.username) registered")
                            self.errorMsg = ""
                        }
                        else {
                            self.errorMsg = "User already exists"
                        }
                    }
                }
                else {
                    self.errorMsg = "Passwords aren't matching"
                }
            }
            else {
                self.errorMsg = "Some fields are empty"
            }
            
        }
    }
}
