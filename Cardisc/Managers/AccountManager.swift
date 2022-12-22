//
//  LoginManager.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/11/2022.
//

import Foundation

class AccountManager {
    let defaults = UserDefaults.standard
    private let apiService = ApiService()
    
    func loginUser(username: String, password: String, completion:@escaping (loginResponseDto?) -> ()) {
        let body: [String: AnyHashable] = [
            "username": username,
            "password": password
        ]
        
        apiService.postData(body: body, url: Constants.API_BASE_URL + "login", model: loginResponseDto.self) { data in
            
            self.defaults.set(data.accessToken, forKey: "X-AUTHTOKEN")

            do {
                let encoder = JSONEncoder()
                let user = try encoder.encode(data)
                self.defaults.set(user, forKey: "user")
                
                

            } catch {
                print("Unable to Encode Note (\(error))")
            }
            
            completion(data)
            
        } failure: { error in
            completion(nil)
        }
    }
    
    func registerUser(username: String, password: String, emailadress: String, completion:@escaping (registerResponseDto) -> ()) {
        let body: [String: AnyHashable] = [
            "username": username,
            "password": password,
            "email": emailadress
        ]
        
        apiService.postData(body: body, url: Constants.API_BASE_URL + "user", model: registerResponseDto.self) { data in
            print(data)
            completion(data)
            
        } failure: { error in
            print(error)
        }
    }
}
