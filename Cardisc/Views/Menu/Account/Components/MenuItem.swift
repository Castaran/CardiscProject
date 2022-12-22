//
//  MenuItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct MenuItem: View {
    
    let menuIcon: String
    let iconHeight: CGFloat
    let iconWidth: CGFloat
    let menuTitle: String
    let menuColor: UIColor
    let menuPaddingRight: CGFloat?
    var isLoading: Bool = false
    
    var body: some View {
        HStack {
            HStack{
                if (isLoading) {
                    ProgressView()
                        .frame(width: iconWidth, height: iconHeight)
                        .padding(.trailing, 5)
                        .foregroundColor(Color.white)
                }
                else {
                    Image(systemName: menuIcon)
                        .resizable()
                        .frame(width: iconWidth, height: iconHeight)
                        .padding(.trailing, 5)
                }
                
                Text(menuTitle).font(.system(size: 18)).bold()
            }
            .padding(.trailing, menuPaddingRight ?? 70)
            .padding(.leading, 20)
            .padding(.vertical, 15)
            .background(Color(menuColor))
            .foregroundColor(Color.white)
            .cornerRadius(13, corners: [.topLeft, .bottomLeft])
            .shadow(radius: 15)
            .padding(.vertical, 10)
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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
