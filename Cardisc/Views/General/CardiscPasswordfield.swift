//
//  SettingsPasswordfield.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 01/01/2023.
//

import Foundation
import SwiftUI

struct CardiscPasswordfield: View {
    @State var value: Binding<String>
    let label: String
    
    var body: some View {
        VStack {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .foregroundColor(Color(UIColor.white))
            SecureField(
                "********",
                text: value
            )
            .keyboardType(.asciiCapable)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .autocapitalization(.none)
            .background(Color.white)
            .cornerRadius(10)
        }
        .padding(.vertical, 5)
    }
    
}

