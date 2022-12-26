//
//  NavigationLazyView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 26/12/2022.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
