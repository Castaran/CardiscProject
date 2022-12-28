//
//  StartViewModel.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 28/12/2022.
//

import Foundation

class StartViewModel: ObservableObject {
    func userLoggedIn() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "X-AUTHTOKEN") != nil{
            return true
        }
        return false
    }
}
