//
//  UserViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation
import SwiftUI
import PhotosUI

class UserViewModel: ObservableObject {
    private let userManager = UserManager()
    
    @Published var currentUser = userDto(id: "", username: "", email: "", picture: "")
    @Published var showDeleteUserComfirmation: Bool = false
    @Published var userDeleted: Bool = false
    @Published var confirmMessageShow: Bool = false
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var data: Data?
    @Published var image: Image?
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var password2: String = ""
    
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    init(currentUser: userDto = userDto(id: "", username: "", email: "", picture: "")) {
        if let currentUser = UserDefaults.standard.data(forKey: "user") {
            do {
                let decoder = JSONDecoder()
                self.currentUser = try decoder.decode(loginResponseDto.self, from: currentUser).user
                self.username = self.currentUser.username
                self.email = self.currentUser.email
                
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
    
    func deleteUser() {
        DispatchQueue.main.async {
            self.userManager.deleteUserById(id: self.currentUser.id)
            UserDefaults.standard.removeObject(forKey: "X-AUTHTOKEN")
            UserDefaults.standard.removeObject(forKey: "user")
            self.userDeleted = true
        }
        
    }
    
    func updateUser() {
        if(self.username != self.currentUser.username) {
            print("Username changed")
        }
        if(self.email != self.currentUser.email) {
            print("Emailadress changed")
        }
        if(!password.isEmpty || !password2.isEmpty) {
            if(password == password2) {
                if(password.count > 8) {
                    if((password.rangeOfCharacter(from: .uppercaseLetters)) != nil) {
                        if((password.rangeOfCharacter(from: .lowercaseLetters)) != nil) {
                            if((password.rangeOfCharacter(from: .decimalDigits)) != nil) {
                                if((password.rangeOfCharacter(from: .symbols)) != nil) {
                                    print("Password OK")
                                }
                                else {
                                    print("Password must at least contain one special character")
                                }
                            }
                            else {
                                print("Password must at least contain one numeric character")
                            }
                        }
                        else {
                            print("Password must at least contain one lowercase character")
                        }
                    }
                    else {
                        print("Password must at least contain one uppercase character")
                    }
                }
                else {
                    print("Password should at least be 8 characters long, please try another one.")
                }
            }
            else {
                print("Passwords aren't matching!")
            }
        }
    }
    
    func uploadAvatar() {
        //..
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }
}

