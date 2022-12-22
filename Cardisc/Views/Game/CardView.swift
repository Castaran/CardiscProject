//
//  MainMenu.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct CardView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "iphone.badge.play").resizable().foregroundColor(Color.white).frame(width: 25, height: 30)
                    Text("Question Room").font(.system(size: 28)).foregroundColor(Color.white).bold()
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 30)
                
                MPCQuestionCard()
                
                VStack {
                    NavigationLink {
                        ChatView()
                    } label: {
                        HStack {
                            MenuItem(menuIcon: "play.fill", iconHeight: 22, iconWidth: 22, menuTitle: "Play card", menuColor: UIColor.systemBlue, menuPaddingRight: 40)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Image("WP2")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+70)
                .brightness(-0.08)
            )
        }
        .navigationBarHidden(true)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
