//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//


import SwiftUI

struct TimeLineContainerView: View {
    @StateObject private var dataProvider = DataProvider()
    @Namespace private var animationNamespace
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    if dataProvider.isLoading {
                        ProgressView("Loading content...")
                            .padding()
                    } else {
                        // Stories Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(dataProvider.stories) {
                                    StoryView(story: $0)
                                }
                            }
                        }
                        
                        // Posts Section
                        ForEach(Array(dataProvider.posts.enumerated()), id: \.element.id) { index, post in
                            NavigationLink(destination: FullScreenPostView(posts: dataProvider.posts, initialIndex: index, animationNamespace: animationNamespace)) {
                                PostView(post: post, screenWidth: UIScreen.main.bounds.size.width)
                                    .matchedGeometryEffect(id: post.id, in: animationNamespace)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 20)
                            .onAppear {
                                // Load more posts when reaching the last few posts
                                if index >= dataProvider.posts.count - 3 {
                                    Task {
                                        await dataProvider.loadMorePosts()
                                    }
                                }
                            }
                        }
                        
                        // Pagination Loading Indicator
                        if dataProvider.isPaginating {
                            HStack {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text("Loading more posts...")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        }
                    }
                }
            }
            .refreshable {
                await dataProvider.refreshData()
            }
            .applyTimelineNavigationBar()
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineContainerView()
    }
}
