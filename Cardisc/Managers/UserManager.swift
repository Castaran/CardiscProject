//
//  UserManager.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI
import PhotosUI
import MultipartForm

class UserManager {
    let defaults = UserDefaults()
    private let apiService = ApiService()
    
    func logoffUser() {
        self.defaults.removeObject(forKey: "X-AUTHTOKEN")
        self.defaults.removeObject(forKey: "USERID")
    }
    
    func deleteUserById(id: String) {
        apiService.httpRequestWithoutReturn(body: nil, url: "user/\(id)", httpMethod: "DELETE")
    }
    
    func updateUser(username: String, password: String, email: String, completion:@escaping (User?) -> ()) {
        var body: [String: AnyHashable] = [
            "username": username,
            "email": email,
            "password": password
        ]
        
        apiService.httpRequest(body: body, url: "user/", model: userDto.self, httpMethod: "PUT") {
            data in
            self.defaults.removeObject(forKey: "X-AUTHTOKEN")
            self.defaults.removeObject(forKey: "USERID")
            self.defaults.removeObject(forKey: "user")
            completion(data.toDomainModel())
        } failure: { error in
            completion(nil)
        }
    }
    
    func uploadAvatar(uiimage: UIImage, id: String, completion:@escaping (User?) -> ()) {
        let imageData: Data = uiimage.jpegData(compressionQuality: 0.1) ?? Data()
        
        let formData = MultipartForm(parts: [
        MultipartForm.Part(name: "image", data: imageData, filename: "userAvatar.png", contentType: "image/png"),
        ])
        
        DispatchQueue.main.async {
            self.apiService.httpUploadRequest(model: userDto.self, formData: formData)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.apiService.httpRequest(body: nil, url: "user/\(id)", model: userDto.self, httpMethod: "GET") { data in
                completion(data.toDomainModel())
            } failure: { error in
                print(error.localizedDescription)
            }
        }
        
    }
}

