//
//  Register.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterViewModel()
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus.fill")
                        .resizable()
                        .frame(width: 30, height: 28)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 5)
                    Text("Register").font(.system(size: 24)).foregroundColor(Color.white).bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack {
                    HStack {
                        Text("Login to your Cardisc-Account to gain access to the game.")
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
                }.padding(.bottom, 10)
                
                VStack {
                    Text("Emailadress").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                    TextField(
                        "...",
                        text: $vm.emailaddress
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(10)
                }.padding(.bottom, 10)
                
                VStack {
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
                }.padding(.bottom, 10)
                
                VStack {
                    Text("Password repeated").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                    SecureField(
                        "...",
                        text: $vm.passwordRepeated
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                
            }.padding(.horizontal, 30)
            
            NavigationLink("", destination: StartView(), isActive: $vm.isActive)
            MenuItem(menuIcon: "person.crop.circle.badge.plus.fill", iconHeight: 26, iconWidth: 30, menuTitle: "Register", menuColor: UIColor.systemBlue, menuPaddingRight: 40).onTapGesture {
                if(vm.password == vm.passwordRepeated) {
                    if(vm.registerUser(username: vm.username, password: vm.password, email: vm.emailaddress)) {
                        vm.isActive = true
                    }
                    else {
                    }
                }
                
            }
            .padding(.top, 15)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .background(Image("WP1").resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
