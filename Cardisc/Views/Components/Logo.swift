//
//  Logo.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 28/12/2022.
//

import Foundation
import SwiftUI

struct Logo: View {
    
    var body: some View {
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
            Spacer()
        }
    }
}

