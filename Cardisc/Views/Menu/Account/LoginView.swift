//
//  Login.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus.fill")
                        .resizable()
                        .frame(width: 30, height: 28)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 5)
                    Text("Login").font(.system(size: 24)).foregroundColor(Color.white).bold()
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack {
                    Text("Login to your Cardisc-Account")
                        .foregroundColor(Color.white).padding(.bottom, 20)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("Username").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                TextField(
                    "...",
                    text: $vm.username
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white)
                .autocapitalization(.none)
                .cornerRadius(10)
                
                Text("Password").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                SecureField(
                    "...",
                    text: $vm.password
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .autocapitalization(.none)
                .background(Color.white)
                .cornerRadius(10)

            }
            .padding(.horizontal, 30)
            NavigationLink("", destination: StartView(), isActive: $vm.isActive)
            MenuItem(menuIcon: "lock.open.fill", iconHeight: 26, iconWidth: 30, menuTitle: "Login", menuColor: UIColor.systemBlue, menuPaddingRight: 40).onTapGesture {
                vm.loginUser(username: vm.username, password: vm.password)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Image("WP1").resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        
    }
    
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}


