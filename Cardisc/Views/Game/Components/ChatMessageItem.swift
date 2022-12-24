//
//  ChatMessageItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 24/11/2022.
//

import Foundation
import SwiftUI

struct ChatMessageItem: View {
    
    let name: String?
    let message: String
    
    let msgWidth: CGFloat = 170
    
    var body: some View {
        if let name = self.name {
            HStack {
                VStack (alignment: .leading)
                {
                    HStack {
                        Text(name).bold()
                    }
                    .padding(.horizontal, 3)
                    HStack () {
                        Text(message)
                    }
                    .padding(.horizontal, 3)
                }
                .padding(10)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(15, corners: [.topRight, .bottomRight, .bottomLeft])
                .frame(maxWidth: msgWidth, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
        else {
            HStack (alignment: .lastTextBaseline) {
                VStack
                {
                    HStack {
                        Text(message).foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 5)
                    
                }
                .padding(10)
                .background(Color(UIColor.systemBlue))
                .cornerRadius(15, corners: [.topLeft, .bottomRight, .bottomLeft])
                .frame(maxWidth: msgWidth, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 10)
        }
    }
}


