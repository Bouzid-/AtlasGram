//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct FullScreenPostView: View {
    @Binding var posts: [Post]
    let initialIndex: Int
    let animationNamespace: Namespace.ID
    @Environment(\.presentationMode) var presentationMode
    @State private var currentIndex: Int
    
    init(posts: Binding<[Post]>, initialIndex: Int, animationNamespace: Namespace.ID) {
        self._posts = posts
        self.initialIndex = initialIndex
        self.animationNamespace = animationNamespace
        self._currentIndex = State(initialValue: initialIndex)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(Array(posts.enumerated()), id: \.element.id) { index, post in
                    SingleFullScreenPostView(
                        post: $posts[index],
                        animationNamespace: animationNamespace
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .offset(y: -CGFloat(currentIndex) * geometry.size.height)
            .simultaneousGesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        
                        print("Main gesture triggered: \(value.translation)")
                        
                        // Only handle vertical swipes (up/down)
                        if abs(value.translation.height) > abs(value.translation.width) {
                            if value.translation.height < -threshold {
                                // Swipe up - next post
                                print("Swiping to next post")
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    if currentIndex < posts.count - 1 {
                                        currentIndex += 1
                                    }
                                }
                            } else if value.translation.height > threshold {
                                // Swipe down - previous post
                                print("Swiping to previous post")
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    if currentIndex > 0 {
                                        currentIndex -= 1
                                    }
                                }
                            }
                        }
                    }
            )
        }
        .clipped()
    }
}
    
    // MARK: - Single Post View
    struct SingleFullScreenPostView: View {
        @Binding var post: Post
        let animationNamespace: Namespace.ID
        @Environment(\.presentationMode) var presentationMode
        @State private var showComments = false
        @State private var showHeartAnimation = false
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    // Full screen image
                    RemoteImage(url: post.postImage, fallbackImageName: "post_1")
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea(.all)
                        .matchedGeometryEffect(id: post.id, in: animationNamespace)
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
                    
                    // Top navigation bar overlay
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                // Share action
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    // Bottom overlay with gradient background
                    VStack {
                        Spacer()
                        
                        // Gradient overlay for better text readability
                        VStack(spacing: 15) {
                            // User info and actions
                            HStack {
                                // User profile
                                HStack(spacing: 10) {
                                    CircularRemoteImage(url: post.user.userImage, fallbackImageName: "user_1", size: 32)
                                    
                                    Text(post.user.userName)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                // Action buttons
                                HStack(spacing: 20) {
                                    Button(action: {
                                        toggleLike()
                                    }) {
                                        Image(systemName: post.hasLiked ? "heart.fill" : "heart")
                                            .foregroundColor(post.hasLiked ? .red : .white)
                                            .font(.title2)
                                    }
                                    
                                    Button(action: {
                                        showComments = true
                                    }) {
                                        Image(systemName: "message")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    
                                    Button(action: {
                                        // Share action
                                    }) {
                                        Image(systemName: "paperplane")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        post.hasBookmarked.toggle()
                                        
                                        // Persist the bookmark state
                                        if post.hasBookmarked {
                                            PersistenceManager.shared.addBookmarkedPost(post.id)
                                        } else {
                                            PersistenceManager.shared.removeBookmarkedPost(post.id)
                                        }
                                    }) {
                                        Image(systemName: post.hasBookmarked ? "bookmark.fill" : "bookmark")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            // Likes count
                            HStack {
                                Text(post.likes)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            // Caption
                            HStack {
                                Text(post.user.userName)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white) +
                                Text(" \(post.caption)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            // View comments
                            HStack {
                                Button(action: {
                                    showComments = true
                                }) {
                                    Text("View all comments")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            // Time ago
                            HStack {
                                Text("2 hours ago")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 30)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.clear,
                                    Color.black.opacity(0.3),
                                    Color.black.opacity(0.7)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 100
                        
                        print("Child gesture triggered: \(value.translation)")
                        
                        // Only handle horizontal right swipes for dismiss
                        if value.translation.width > threshold && abs(value.translation.width) > abs(value.translation.height) {
                            print("Dismissing fullscreen view")
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            )
            .navigationBarHidden(true)
            .statusBarHidden()
            .sheet(isPresented: $showComments) {
                CommentsView(post: post)
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
    }
    
    // MARK: - Comments View
    struct CommentsView: View {
        let post: Post
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            NavigationView {
                VStack {
                    // Header
                    HStack {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        Spacer()
                        
                        Text("Comments")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding()
                    
                    // Comments list placeholder
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(0..<5) { index in
                                HStack(alignment: .top, spacing: 10) {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 32, height: 32)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text("user\(index + 1)")
                                                .font(.system(size: 14, weight: .semibold))
                                            Text("2h")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Text("Amazing photo! 🔥")
                                            .font(.system(size: 14))
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                    
                    Spacer()
                    
                    // Comment input
                    HStack {
                        TextField("Add a comment...", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Post") {
                            // Post comment action
                        }
                        .foregroundColor(.blue)
                    }
                    .padding()
                }
            }
        }
    }
    
    struct FullScreenPostView_Previews: PreviewProvider {
        @Namespace static var namespace
        
        static var previews: some View {
            FullScreenPostView(posts: .constant(LocalPostProvider.generatePosts(count: 5)), initialIndex: 0, animationNamespace: namespace)
        }
    }
