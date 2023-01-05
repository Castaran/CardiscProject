//
//  CustomModifiers.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 28/12/2022.
//

import Foundation
import SwiftUI
import Combine

struct BackgroundImage: ViewModifier {
    
    var imageName: String
    
    func body(content: Content) -> some View {
        content
            .background(Image(imageName).resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

struct ConfirmMessage: ViewModifier {
    @State var trigger: Bool
    var message: String
    var title: String
    var button: String
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $trigger) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: .destructive(Text(button)),
                    secondaryButton: .cancel()
                )}
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    
    func backgroundImage(imageName: String = "WP1") -> some View {
        modifier(BackgroundImage(imageName: imageName))
    }
    
    func confirmMessage(title: String, message: String, button: String, trigger: Bool) -> some View {
        modifier(ConfirmMessage(trigger: trigger, message: message, title: title, button: button))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
}
