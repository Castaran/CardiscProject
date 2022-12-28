//
//  ContentView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import SwiftUI

struct StartView: View {
    
    let defaults = UserDefaults.standard
    var body: some View {
        
        if let token = defaults.string(forKey: "X-AUTHTOKEN"){
            NavigationStack {
                MainMenuView()
            }
        }
        else {
            NavigationStack {
                LoginMainView()
            }
        }
    }
    
}
