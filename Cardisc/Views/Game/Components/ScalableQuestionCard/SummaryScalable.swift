//
//  PlayerAnswerScalable.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 30/12/2022.
//

import Foundation
import SwiftUI

struct SummaryScalable: View {
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Answers: ").bold()
                Spacer()
                Text("\(vm.answers.count)/\(vm.players.count)")
            }

            HStack {
                Text("Average score: \(String(format: "%.1f", vm.averageScalable * 20))%")
                Spacer()
            }
            .padding(.vertical, 10)
            
            HStack {
                Slider(value: $vm.averageScalable, in: 1...5, step: 0.1).disabled(true)
            }
            .padding(.horizontal, 10)
            HStack {
                Text("Disagree")
                Spacer()
                Text("Agree")
            }
        }
        .foregroundColor(Color.black)
        .padding(15)
        .background(Color.white)
        .cornerRadius(10, corners: [.allCorners])
        .padding(.horizontal, 30)
        .shadow(radius: 10)
    }
}

