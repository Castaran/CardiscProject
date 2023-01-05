//
//  PlayerAnswerList.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 24/12/2022.
//

import Foundation
import SwiftUI

struct SummaryOpen: View {
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Answers: ").bold()
                Spacer()
                Text("Completed \(vm.answers.count)/\(vm.players.count)")
            }
            
            Divider()
            
            ScrollViewReader { scrollView in
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(vm.answers) { answer in
                            PlayerAnswerOpen(answer: answer).id(answer.id)
                        }
                    }
                }
                .animation(.easeIn, value: vm.answers)
                .onChange(of: vm.answers) { newValue in
                    scrollView.scrollTo(vm.answers.last?.id)
                }
            }
            
        }
        .foregroundColor(Color.black)
        .padding(15)
        .background(Color.white)
        .cornerRadius(10, corners: [.allCorners])
        .padding(.horizontal, 30)
        .shadow(radius: 5)
        .frame(maxHeight: 220)
        .padding(.bottom, 20)
    }
}


