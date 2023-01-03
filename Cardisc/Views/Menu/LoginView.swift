//
//  Login.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject private var vm = LoginViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus.fill")
                        .resizable()
                        .frame(width: 32, height: 28)
                        .foregroundColor(Color.white)
                        .padding(.trailing, 5)
                    Text("Login").font(.system(size: 24)).foregroundColor(Color.white).bold()
                    Spacer()
                }
                
                
                HStack {
                    Text("Login to your Cardisc-Account").foregroundColor(Color.white).padding(.bottom, 20)
                    Spacer()
                }
                
                HStack {
                    Text("Username").bold().foregroundColor(Color(UIColor.white))
                    Spacer()
                }
                
                TextField(
                    "JohnDoe123",
                    text: $vm.username
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white)
                .foregroundColor(Color(vm.usernameFieldColor))
                .autocapitalization(.none)
                .cornerRadius(10)
                
                HStack {
                    Text("Password").bold().foregroundColor(Color(UIColor.white))
                    Spacer()
                }
                
                SecureField(
                    "*********",
                    text: $vm.password
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .autocapitalization(.none)
                .background(Color.white)
                .foregroundColor(Color(vm.passwordFieldColor))
                .cornerRadius(10)
                
                HStack {
                    Text(vm.errorMessage).foregroundColor(Color.white)
                    Spacer()
                }
                

            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            MenuItem(menuIcon: "lock.open.fill", iconHeight: 26, iconWidth: 30, menuTitle: "Login", menuColor: UIColor.systemBlue, menuPaddingRight: 40, isLoading: vm.isRequestInProgress
            ).onTapGesture {
                vm.loginUser()
            }
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .backgroundImage()
        .navigationDestination(isPresented: $vm.loggedIn) { StartView() }
        
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}


