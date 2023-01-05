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
    private var tempUser: [String: AnyHashable] = [:]
    
    @Published var currentUser = User(id: "", username: "", email: "", picture: "")
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
    @Published var errorMsg: String = ""
    @Published var changedUserDetails = ""
    @Published var updatedUser: Bool = false
    
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
                self.currentUser = try decoder.decode(loginResponseDto.self, from: currentUser).user.toDomainModel()
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
        self.errorMsg = ""
        self.changedUserDetails = ""
        self.updatedUser = false
        
        
        if(self.username != self.currentUser.username) {
            if(!self.username.isEmpty) {
                self.changedUserDetails += "Username \(currentUser.username) -> \(self.username) \n"
            }
            else {
                self.errorMsg = "Username field can not be empty"
            }
        }
        
        if(self.email != self.currentUser.email) {
            if(!self.email.isEmpty) {
                self.changedUserDetails += "Email \(currentUser.email) -> \(self.email) \n"
            }
            else {
                self.errorMsg = "Emailfield can not be empty"
            }
        }
        
        if(self.password != "" && self.password2 != "") {
            if(password == password2) {
                self.changedUserDetails += "Password ****** -> \(self.password) \n"
            }
            else {
                self.errorMsg = "Passwords aren't matching!"
            }
        }
        
        if(self.errorMsg.isEmpty && !self.changedUserDetails.isEmpty) {
            DispatchQueue.main.async {
                self.userManager.updateUser(username: self.username, password: self.password, email: self.email) { data in
                    if(data?.username != nil) {
                        self.currentUser = data!
                        self.updatedUser = true
                    }
                    else {
                        self.errorMsg = "Username aleady exists"
                    }
                }
            }
        }
    }
    
    func uploadAvatar() {
        
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

