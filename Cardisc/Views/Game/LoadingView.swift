//
//  LoadingView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    let title: String
    let message: String
    let icon: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: icon).resizable().foregroundColor(Color.white).frame(width: 25, height: 30)
                Text(title).font(.system(size: 28)).foregroundColor(Color.white).bold()
            }
            
            VStack {
                Text(message)
            }
            .foregroundColor(Color.white)
            .padding(.horizontal, 90)
            .padding(.bottom, 30)
            Spacer()
        }
        .backgroundImage()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: "Loading view", message: "Please wait while the next view is being loaded..", icon: "hourglass.tophalf.filled")
    }
}
