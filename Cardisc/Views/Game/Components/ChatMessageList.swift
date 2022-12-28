//
//  ChatMessageList.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 25/12/2022.
//

import Foundation
import SwiftUI

struct ChatMessageList: View {
    @Binding var chatMessages: [ChatMessage]
    
    var body: some View {
        //SIBTAIN: can you make this auto scrollable? That when it gets reloaded, it automaticly scrolls to bottom?
        ScrollViewReader { scrollView in
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(chatMessages) { message in
                        ChatMessageItem(name: message.username, message: message.message)
                            .id(message.id)
                    }
                }
                
            }
            .animation(.easeIn, value: chatMessages)
            .onChange(of: chatMessages) { newValue in
                scrollView.scrollTo(chatMessages.last?.id)
            }
            
        }
        .padding(.top, 10)
        
    }
}
