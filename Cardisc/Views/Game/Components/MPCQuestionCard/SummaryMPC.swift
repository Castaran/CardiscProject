//
//  PlayerAnswerListMPC.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 30/12/2022.
//

import Foundation
import SwiftUI

struct SummaryMPC: View {
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Answers: ").bold()
                Spacer()
                Text("Completed \(vm.answers.count)/\(vm.players.count)")
            }
            Divider()
            HStack {
                ForEach(vm.summaryMPC.keys.sorted(), id: \.self) { key in
                    VStack{
                        Spacer()
                        Text("\(vm.summaryMPC[key]!)")
                        
                        HStack{}.frame(width: 35, height: CGFloat(vm.summaryMPC[key]!*10)).background(Color(UIColor.systemBlue)).shadow(radius: 5)
                        
                        Text("\(key)")
                    }.padding(.horizontal, 20).frame(maxHeight: 150)
                }
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

