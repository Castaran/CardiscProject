//
//  EditAccountSettingsView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 21/11/2022.
//

import Foundation
import SwiftUI

struct EditAccountSettingsView: View {
    @ObservedObject var vm: UserViewModel
    
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
                            Spacer()
                        }
                        
                        
                        
                        HStack {
                            Text("Edit your profile information bellow")
                                .foregroundColor(Color.white).padding(.bottom, 20)
                            Spacer()
                        }
                        
                        
                        CardiscTextfield(value: $vm.username, label: "Username")
                        
                        CardiscTextfield(value: $vm.email, label: "Emailadress")
                        
                        CardiscPasswordfield(value: vm.password, label: "New password")
                        
                        CardiscPasswordfield(value: vm.password2, label: "New password repeated")
                        
                    }
                }
                
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            MenuItem(menuIcon: "checkmark", iconHeight: 22, iconWidth: 26, menuTitle: "Confirm", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
            
            Spacer()
        }
        .backgroundImage()
    }
}
