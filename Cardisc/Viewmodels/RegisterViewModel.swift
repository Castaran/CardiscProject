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
    @Published var isActive: Bool = false
    
    func registerUser(username: String, password: String, email: String) -> Bool {
        var response = false
        accountManager.registerUser(username: username, password: password, emailadress: email) { data in
            response = true
            
        }
        sleep(1)
        return response
    }
    
}
