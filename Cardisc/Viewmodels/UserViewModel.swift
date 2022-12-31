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
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var data: Data?
    @Published var image: Image?
    
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
        //..
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

