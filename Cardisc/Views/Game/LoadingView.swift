//
//  LoadingView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @ObservedObject var vm: GameViewModel
    let title: String
    let message: String
    
    var body: some View {
        NavigationLink("", destination: CardView(vm: vm), isActive: $vm.nextView).onAppear{ vm.nextView = false }
        
        VStack {
            HStack {
                Image(systemName: "hourglass.tophalf.filled").resizable().foregroundColor(Color.white).frame(width: 25, height: 30)
                Text(title).font(.system(size: 28)).foregroundColor(Color.white).bold()
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 30)
            
            HStack {
                Text(message)
            }
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 30)
        .background(Image("WP2")
            .resizable()
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+70)
        )
        .navigationBarHidden(true)
    }
}
