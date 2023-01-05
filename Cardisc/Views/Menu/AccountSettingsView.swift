//
//  AccountSettings.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI
import PhotosUI

struct AccountSettingsView: View {
    @ObservedObject var vm = UserViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack {
                VStack{
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 30, height: 28)
                            .foregroundColor(Color.white)
                        
                        Text("Account settings").font(.system(size: 24)).foregroundColor(Color.white).bold()
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        if(vm.currentUser.picture != "") {
                            AsyncImage(url: URL(string: vm.currentUser.picture)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(20)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.black)
                        }
                        VStack {
                            HStack {
                                Text(vm.currentUser.username)
                                    .bold()
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.black)
                                Spacer()
                            }
                            Divider().frame(height: 0.2)
                            VStack {
                                HStack {
                                    Text("Email:")
                                    Spacer()
                                    Text(vm.currentUser.email)
                                }
                                HStack {
                                    Text("Password:")
                                    Spacer()
                                    Text("********")
                                }
                            }
                            .foregroundColor(Color.gray)
                        }
                        .padding(.trailing,40)
                        .padding(.vertical, 20)
                        .font(.system(size: 14))
                        
                        Spacer()
                    }
                    
                    .background(Color(UIColor.white))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    
                    
                }.padding(.horizontal, 30)
                
                NavigationLink {
                    EditAccountSettingsView(vm: vm)
                } label: {
                    HStack {
                        MenuItem(menuIcon: "square.and.pencil", iconHeight: 26, iconWidth: 26, menuTitle: "Edit account info", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 50)
                }
                
                PhotosPicker(
                    selection: $vm.imageSelection,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    MenuItem(menuIcon: "camera.fill", iconHeight: 22, iconWidth: 30, menuTitle: "Change picture", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
                }
                
                NavigationLink {
                    TestView()
                }label: {
                    MenuItem(menuIcon: "camera.fill", iconHeight: 22, iconWidth: 30, menuTitle: "Change picture", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
                }
                
                
                MenuItem(menuIcon: "trash.fill", iconHeight: 26, iconWidth: 26, menuTitle: "Delete account", menuColor: UIColor.systemRed, menuPaddingRight: 40).onTapGesture {
                    vm.showDeleteUserComfirmation = true
                }
                
                Spacer()
            }
            .padding(.top, 20)
        }
        .backgroundImage()
        .navigationDestination(isPresented: $vm.userDeleted, destination: {
            StartView()
        })
        .alert(isPresented: $vm.showDeleteUserComfirmation) { Alert(
            title: Text("Deleting account permanently"),
            message: Text("Are you sure you want to delete your account? There is no way back from that point."),
            primaryButton: .destructive(Text("Delete")) {
                vm.deleteUser()
            }, secondaryButton: .cancel())}
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}

