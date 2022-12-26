//
//  EditAccountSettingsView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 21/11/2022.
//

import Foundation
import SwiftUI

struct EditAccountSettingsView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var accounttype: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    
    var body: some View {
        
        VStack {
            VStack {
                VStack {
                    VStack{
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 30, height: 28)
                                .foregroundColor(Color.white)
                            Text("Edit account settings").font(.system(size: 24)).foregroundColor(Color.white).bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        HStack {
                            Text("Edit your profile information bellow")
                                .foregroundColor(Color.white).padding(.bottom, 20)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        VStack {
                            Text("Username").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                            TextField(
                                "...",
                                text: $username
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(Color.white)
                            .autocapitalization(.none)
                            .cornerRadius(10)
                        }.padding(.bottom, 5)
                        
                        VStack {
                            Text("Emailadress").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                            TextField(
                                "...",
                                text: $email
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .autocapitalization(.none)
                            .background(Color.white)
                            .cornerRadius(10)
                        }.padding(.bottom, 5)
                        
                        VStack {
                            Text("Account Type").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                            TextField(
                                "...",
                                text: $accounttype
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .autocapitalization(.none)
                            .background(Color.white)
                            .cornerRadius(10)
                        }.padding(.bottom, 5)
                        
                        VStack {
                            Text("Password").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                            TextField(
                                "...",
                                text: $password
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .autocapitalization(.none)
                            .background(Color.white)
                            .cornerRadius(10)
                        }.padding(.bottom, 5)
                        
                        VStack {
                            Text("Password repeated").frame(maxWidth: .infinity, alignment: .leading).bold().foregroundColor(Color(UIColor.white))
                            TextField(
                                "...",
                                text: $password2
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .autocapitalization(.none)
                            .background(Color.white)
                            .cornerRadius(10)
                        }.padding(.bottom, 5)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 30)
            }
            
            MenuItem(menuIcon: "checkmark", iconHeight: 26, iconWidth: 30, menuTitle: "Confirm", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
        }
        .background(Image("WP1").resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

struct EditAccountSettings: PreviewProvider {
    static var previews: some View {
        EditAccountSettingsView()
    }
}
