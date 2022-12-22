//
//  UserViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation

class UserViewModel: ObservableObject {
    private let userManager = UserManager()
    @Published var currentUser = userDto(id: "", username: "", email: "", picture: "")
    
    
    init(currentUser: userDto = userDto(id: "", username: "", email: "", picture: "")) {
        if let currentUser = UserDefaults.standard.data(forKey: "user") {
            do {
                let decoder = JSONDecoder()
                self.currentUser = try decoder.decode(loginResponseDto.self, from: currentUser).user
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        else {
            print("No user found")
        }
    }
    
    func logoffUser() {
        userManager.logoffUser()
    }
    
    
    func getUserById() {
        //..
    }
    
    func deleteUserById() {
        //..
    }
    
    func createNewUser() {
        //..
    }
    
    func updateUser() {
        //..
    }
    
    func uploadAvatar() {
        //..
    }
    
    func getInfo(userDefaults: String) -> String {
        if let info = userManager.defaults.string(forKey: userDefaults) {
            return info
        }
        return ""
    }
}

