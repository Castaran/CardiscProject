//
//  ContentView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var vm = StartViewModel()
    var body: some View {
        if (vm.userLoggedIn()){
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
