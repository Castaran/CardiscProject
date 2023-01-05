//
//  UserManager.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation

class UserManager {
    let defaults = UserDefaults()
    private let apiService = ApiService()
    
    func logoffUser() {
        self.defaults.removeObject(forKey: "X-AUTHTOKEN")
        self.defaults.removeObject(forKey: "USERID")
    }
    
    func getUserById(id: Int, completion:@escaping (User) -> ()) {
        apiService.httpRequest(body: nil, url: "users/\(id)", model: userDto.self, httpMethod: "POST") { data in
            completion(data.toDomainModel())
        } failure: { error in
            print(error)
        }
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
    
    func uploadAvatar(id: Int, completion:@escaping (User) -> ()) {
        apiService.httpRequest(body: nil, url: "users/\(id)", model: userDto.self, httpMethod: "POST") { data in
            completion(data.toDomainModel())
        } failure: { error in
            print(error)
        }
    }
    
    
}

