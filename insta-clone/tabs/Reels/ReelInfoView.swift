//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ReelInfoView: View {
    let video: Video
    var body: some View {
        VStack{
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(video.user.userImage)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                        Text(video.user.userName)
                            .font(Font.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical)
                    Text(video.caption)
                        .font(Font.system(size: 12, weight: .semibold))
                        .lineLimit(2)
                        .padding(.bottom)
                        .foregroundColor(.white)
                }
                .padding(.bottom, -100)
                .padding([.horizontal, .top])
                Spacer()
                VStack(spacing: 10){
                    Button(action: {
                        
                    }) {
                        
                        VStack(spacing: 8){
                            Image(systemName: "heart")
                                .font(.title)
                                .foregroundColor(.white)
                            Text(video.likes)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        VStack(spacing: 8){
                            Image(systemName: "message")
                                .font(.title)
                                .foregroundColor(.white)
                            Text(video.comments)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 8){
                            Image(systemName: "paperplane")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        Image("menu_solid")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                    
                    Image("user_13")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 3))
                }
                .padding(.bottom, 60)
                .padding(.trailing)
            }
        }
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.safeAreaInsets.top ?? 0)
        .padding(.bottom, UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.safeAreaInsets.bottom ?? 0 + 5)
    }
}

struct ReelInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ReelInfoView(video: Video(player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "reel_7", ofType: "mp4")!)),
                                  likes: "17M",
                                  comments: "2k",
                                  caption: "After all, for mankind as a whole there are no exports. We did not start developing by obtaining foreign exchange from Mars or the moon. Mankind is a closed society.",
                                  user: LocalUserProvider.randomUser()))
    }
}
