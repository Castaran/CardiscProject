//
//  LoginMainView.swift
//  Cardisc
//
//  Created by Sibtain Ali (Fiverr) on 28/12/2022.
//

import SwiftUI

struct LoginMainView: View {
    var body: some View {
        
        VStack{
            // Logo
            HStack {
                HStack {
                    Image("Logo")
                        .resizable()
                        .frame(width: 70, height: 70)
                    VStack (
                        alignment: .leading
                    ) {
                        Text("Cardisc").font(.system(size: 32)).bold()
                        Text("An idea developing tool").font(.system(size: 18))
                    }
                }
                .padding(.vertical, 35)
                .padding(.leading, 10)
                .padding(.trailing, 20)
                .background(Color.white)
                .cornerRadius(20, corners: [.topRight, .bottomRight])
                .shadow(radius: 8)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 100)
            
            // Menu
            HStack
            {
                VStack(
                    alignment: .trailing
                ) {
                    NavigationLink(destination: LoginView()) {
                        MenuItem(menuIcon: "person.badge.key.fill", iconHeight: 26, iconWidth: 30, menuTitle: "Login", menuColor: UIColor.systemBlue, menuPaddingRight: nil)
                    }
                    
                    NavigationLink(destination: RegisterView()) {
                        MenuItem(menuIcon: "person.crop.circle.fill.badge.plus", iconHeight: 26, iconWidth: 30, menuTitle: "Register", menuColor: UIColor.systemBlue, menuPaddingRight: 46)
                    }
                    
                    Spacer().frame(height: 30)
                    
                    
                    MenuItem(menuIcon: "arrowshape.turn.up.backward.fill", iconHeight: 26, iconWidth: 30,menuTitle: "Exit", menuColor: UIColor.systemRed, menuPaddingRight: 30).onTapGesture {
                        exit(0)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Image("WP1")
            .resizable()
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+70)
        )
        .navigationBarHidden(true)
    }
}

struct LoginMainView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMainView()
    }
}
