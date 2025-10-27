//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct PostView: View {
    
    @Binding var post: Post
    let screenWidth: CGFloat
    
    @State private var showHeartAnimation = false
    
    init(post: Binding<Post>, screenWidth: CGFloat) {
        self._post = post
        self.screenWidth = screenWidth
    }
    
    var body: some View {
        VStack {
            
            //Post info.
            HStack {
                CircularRemoteImage(url: post.user.userImage, fallbackImageName: "user_1", size: 25)
                    .padding(.leading, 10)

                Text(post.user.userName)
                    .font(Font.system(size: 14, weight: .semibold))

                Spacer()
                Image("menu")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
            }
            .frame(height: 25)
            
            //Image.
            ZStack {
                RemoteImage(url: post.postImage, fallbackImageName: "post_1")
                    .frame(width: screenWidth, height: screenWidth * 1.1)
                    .clipped()
                    .onTapGesture(count: 2) {
                        toggleLike()
                    }
                
                // Heart animation overlay
                if showHeartAnimation {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .scaleEffect(showHeartAnimation ? 1.3 : 0.5)
                        .opacity(showHeartAnimation ? 0 : 1)
                        .animation(.easeOut(duration: 0.6), value: showHeartAnimation)
                }
            }
            
            //Operations menu.
            HStack {
                Button(action: {
                    toggleLike()
                }) {
                    Image(systemName: post.hasLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(post.hasLiked ? .red : .primary)
                }
                .padding(5)
                .padding(.leading, 10)
                Image(systemName: "bubble.right")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                Spacer()
                Button(action: {
                    toggleBookmark()
                }) {
                    Image(systemName: post.hasBookmarked ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(post.hasBookmarked ? .blue : .primary)
                }
                .padding(5)
                .padding(.trailing, 10)
            }
            .frame(height: 20)
            VStack(alignment: .leading, spacing: 0){
                Group {
                    Text(post.user.userName)
                        .font(Font.system(size: 14, weight: .semibold))
                        + Text(" ")
                        + Text(post.caption)
                        .font(Font.system(size: 14))
                }
                .padding(.horizontal, 15)
            }
            .frame(maxWidth: screenWidth, maxHeight: 60, alignment: .leading)
            Text(post.likes)
                .font(Font.system(size: 14, weight: .semibold))
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .frame(width: screenWidth, height: 15, alignment: .leading)
        }
    }
    
    private func toggleLike() {
        withAnimation(.easeInOut(duration: 0.1)) {
            post.hasLiked.toggle()
        }
        
        // Persist the like state
        if post.hasLiked {
            PersistenceManager.shared.addLikedPost(post.id)
        } else {
            PersistenceManager.shared.removeLikedPost(post.id)
        }
        
        // Show heart animation
        if post.hasLiked {
            showHeartAnimation = false
            withAnimation(.easeOut(duration: 0.6)) {
                showHeartAnimation = true
            }
            
            // Hide animation after completion
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                showHeartAnimation = false
            }
        }
    }
    
    private func toggleBookmark() {
        withAnimation(.easeInOut(duration: 0.1)) {
            post.hasBookmarked.toggle()
        }
        
        // Persist the bookmark state
        if post.hasBookmarked {
            PersistenceManager.shared.addBookmarkedPost(post.id)
        } else {
            PersistenceManager.shared.removeBookmarkedPost(post.id)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            PostView(post: .constant(LocalFallbackData.posts.first!), screenWidth: geometry.size.width)
        }
    }
}
