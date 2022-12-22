//
//  PlayerItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 10/12/2022.
//

import Foundation
import SwiftUI

struct PlayerItem: View {
    var player: lobbyPlayerDto
    
    var body: some View {
        HStack {
            if(player.picture != "") {
                AsyncImage(url: URL(string: player.picture))
            }
            else {
                Image(systemName: "person.circle.fill")
            }
            
            Text(player.username)
            
            Spacer()
            
            if(player.ready) {
                Image(systemName: "checkmark.circle.fill").foregroundColor(Color(UIColor.systemGreen))
            }
            else {
                Image(systemName: "multiply.circle.fill").foregroundColor(Color(UIColor.systemRed))
            }
        }
        .padding(.horizontal, 15)
    }
}
