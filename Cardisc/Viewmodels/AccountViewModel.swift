//
//  AccountViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation

class AccountViewModel: ObservableObject {
    
    private let userManager = UserManager()
    
    func loginUser(username: String, password: String) -> Bool {
        var loggedIn = false
        
        userManager.loginUser(username: username, password: password) { data in
            print (data)
            loggedIn = true
            
        }
        sleep(1)
        return loggedIn
    }
    
    func logoffUser() {
        userManager.logoffUser()
    }
    
    func getInfo(userDefaults: String) -> String {
        if let info = userManager.defaults.string(forKey: userDefaults) {
            return info
        }
        return ""
    }
}


