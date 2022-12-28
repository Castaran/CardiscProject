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
            Logo()
            
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
        .backgroundImage()
        .navigationBarHidden(true)
    }
}

struct LoginMainView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMainView()
    }
}
