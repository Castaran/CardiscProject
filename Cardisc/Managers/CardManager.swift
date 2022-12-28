//
//  CardManager.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation

class CardManager {
    let defaults = UserDefaults.standard
    private let apiService = ApiService()
    
    func getCards(id: Int, completion:@escaping (userDto) -> ()) {
        apiService.httpRequest(body: nil, url: "users/\(id)", model: userDto.self, httpMethod: "GET") { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
    
    func getCardById(id: Int, completion:@escaping (userDto) -> ()) {
        apiService.httpRequest(body: nil, url: "users/\(id)", model: userDto.self, httpMethod: "GET") { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
}
