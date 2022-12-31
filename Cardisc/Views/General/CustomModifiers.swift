//
//  CustomModifiers.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 28/12/2022.
//

import Foundation
import SwiftUI

struct BackgroundImage: ViewModifier {
    
    var imageName: String
    
    func body(content: Content) -> some View {
        content
            .background(Image(imageName).resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

extension View {
    
    func backgroundImage(imageName: String = "WP1") -> some View {
        modifier(BackgroundImage(imageName: imageName))
    }
    
}
