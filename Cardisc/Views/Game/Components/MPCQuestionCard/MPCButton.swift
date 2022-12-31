//
//  MPCButton.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 24/12/2022.
//

import Foundation
import SwiftUI

struct MPCButton: View {
    let buttonBody: String
    let color: UIColor
    
    var body: some View {
        ZStack {
            Text(buttonBody)
        } 
        .padding(.vertical, 20)
        .padding(.horizontal, 45)
        .background(Color(uiColor: color))
        .cornerRadius(15, corners: [.allCorners])
        .foregroundColor(Color.white)
        .font(.system(size: 40))
        .shadow(radius: 2)
    }
}
