//
//  PlayerList.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 10/12/2022.
//

import Foundation
import SwiftUI

struct PlayerList: View {
    
    var players: [LobbyPlayer]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Player").bold(true)
                    Spacer()
                    Text("Status").bold(true)
                }
                .padding(.horizontal, 15)
                .padding(.top, 10)
                
                Divider().frame(height: 1).foregroundColor(Color.black).padding(.horizontal, 10)
                
                ForEach(players) { player in
                    PlayerItem(player: player)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 250, alignment: .top)
            .background(Color.white)
            .cornerRadius(10, corners: [.allCorners])
            .padding(.vertical, 5)
        }
    }
}
