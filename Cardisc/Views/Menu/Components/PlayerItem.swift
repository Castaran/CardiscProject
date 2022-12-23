//
//  PlayerItem.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 10/12/2022.
//

import Foundation
import SwiftUI

struct PlayerItem: View {
    var player: LobbyPlayer
    
    var body: some View {
        HStack {
            if(player.picture != "") {
                AsyncImage(url: URL(string: player.picture)).frame(width: 25, height: 25)
            }
            else {
                Image(systemName: "person.circle.fill").resizable().frame(width: 25, height: 25)
            }
            
            Text(player.username).font(.system(size: 20))
            
            Spacer()
            
            if(player.ready) {
                Image(systemName: "checkmark.circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(Color(UIColor.systemGreen))
            }
            else {
                Image(systemName: "multiply.circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(Color(UIColor.systemRed))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}
