//
//  MainMenu.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct CardView: View {
    let vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "iphone.badge.play").resizable().foregroundColor(Color.white).frame(width: 25, height: 30)
                Text("Question Room").font(.system(size: 28)).foregroundColor(Color.white).bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.bottom, 30)
            
            //JUREK: What cardtype is what number?
            if(vm.currentCard.type == 1) {
                ScalableQuestionCard(vm: vm)
            }
            
            else if(vm.currentCard.type == 2) {
                MPCQuestionCard(vm: vm)
            }
            
            else {
                OpenQuestionCard(vm: vm)
            }
        }
        .padding(.top, 30)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Image("WP2")
            .resizable()
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height+70)
            .brightness(-0.08)
        )
        .navigationBarHidden(true)
        
    }
}
