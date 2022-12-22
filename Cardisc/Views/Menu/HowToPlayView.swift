//
//  HowToPlayView.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("WP1")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .brightness(-0.2)
                VStack {
                    VStack{
                        HStack {
                            Image(systemName: "person.fill.questionmark.rtl")
                                .resizable()
                                .frame(width: 30, height: 28)
                                .foregroundColor(Color.white)
                                .padding(.trailing, 5)
                            Text("How-to-play").font(.system(size: 24)).foregroundColor(Color.white).bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }.padding(.horizontal, 30)
                    VStack{
                        ScrollView {
                            HStack {
                                Text("Join a game").foregroundColor(Color.white).bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Joining a game is simple. You only need to enter the Game ID in the textfield in the “Join Game” view. The Game ID is a 4-digit code that you received from a game host. This can be via Whatsapp, email or any other social media-platform. Change your play-status to “Ready” to let the gamehost know that your ready to play the game.").foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Host a game").foregroundColor(Color.white).bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                            HStack {
                                Text("Hosting a game can be done by selecting the “Host a Game” option in the main menu. This will bring you in a Game Lobby where you can invite other plays by sending them the Game ID manually, or generate a automated message via the share-button in the top-right corner and send this via any of your favorite social media-platforms.  When a player joins the game he or she wil be shown in the players-overview in the middle of the screen. This is basicly a list of players that are ready to play the game.").foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Play a game").foregroundColor(Color.white).bold()
                            }
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("When the game starts, one card is handled per round:").foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("If the playing card contains a multiple-choice question, the player is asked to answer it individually. The player reads the question on the card and then enters A, B, C or D. After this, the player is moved to the chat room where the player's answer and that of his fellow players are shown on the screen and the player is given the opportunity to discuss the answers through the chat functionality. After a certain time, the game host determines that the discussion is finished and the next card may be played/answered.").foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                            HStack {
                                Text("If the playing card contains a scalable question, the player is asked to answer it individually. The player reads the question on the card and adjusts the scale according to the player's opinion. After this, the player is moved to the chat room where the player's answer and that of his fellow players are displayed on the screen and the player is given the opportunity to discuss the answers through the chat functionality. After a certain time, the game host determines that the discussion is finished and the next card may be played/answered.").foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                            HStack {
                                Text("If the playing card contains an open question, the player is asked to answer it individually. The player is then moved to the chat room and given the opportunity to view the answers the player and of his or her fellow players and have a discussion/discussion about them via the chat functionality. The game host decides after a certain time that the discussion is finished and the next card may be played/answered. ").foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                    }.padding(.horizontal, 30)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
            }
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
