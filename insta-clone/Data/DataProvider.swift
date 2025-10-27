//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation

@MainActor
class DataProvider: ObservableObject {
    @Published var stories: [Story] = []
    @Published var posts: [Post] = []
    @Published var isLoading = true
    @Published var isPaginating = false
    
    // Testing flag - set to true to bypass API and use local data
    var useLocalData: Bool = false
    
    // Pagination properties
    private var currentPage = 1
    private let postsPerPage = 10
    private var canLoadMore = true
    
    private let unsplashService = UnsplashService()
    
    // Static access to local data that doesn't need API integration
    var activity: [Activity] { LocalFallbackData.activity }
    var videos: [Video] { LocalFallbackData.videos }
    
    init() {
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        isLoading = true
        
        // Check if we should use local data for testing
        if useLocalData {
            print("🧪 Using local fallback data (testing mode)")
            loadFallbackData()
            isLoading = false
            return
        }
        
        do {
            // Load stories and posts concurrently from Unsplash API
            async let storiesData = loadStoriesFromAPI()
            async let postsData = loadPostsFromAPI()
            
            let (loadedStories, loadedPosts) = try await (storiesData, postsData)
            
            self.stories = loadedStories
            self.posts = loadedPosts
            
            print("✅ Successfully loaded \(stories.count) stories and \(posts.count) posts from Unsplash API")
            
        } catch {
            print("⚠️ Failed to load data from Unsplash API: \(error)")
            // Fallback to local static data
            loadFallbackData()
        }
        
        isLoading = false
    }
    
    private func loadStoriesFromAPI() async throws -> [Story] {
        // Fetch portrait photos for Instagram-style stories
        let unsplashPhotos = try await unsplashService.searchPhotos(
            query: "lifestyle portrait people",
            orientation: "portrait",
            count: 16
        )
        
        return unsplashPhotos.map { photo in
            Story(
                user: User(
                    userName: photo.user.username,
                    userImage: photo.user.profileImage.small
                ),
                hasSeen: false,
                isMyStory: false
            )
        }
    }
    
    private func loadPostsFromAPI() async throws -> [Post] {
        // Fetch various photos for Instagram-style posts (initial load)
        let unsplashPhotos = try await unsplashService.searchPhotos(
            query: "nature lifestyle travel photography",
            orientation: "squarish",
            count: postsPerPage
        )
        
        let inspirationalCaptions = [
            "Living life to the fullest! 🌟",
            "Beautiful moments captured forever 📸",
            "Adventures await around every corner 🌍",
            "Finding beauty in everyday moments ✨",
            "Grateful for this amazing journey 🙏",
            "Making memories that last a lifetime 💫",
            "Embracing the magic of the moment 🌈",
            "Life is a beautiful adventure 🦋",
            "Chasing dreams and catching sunsets 🌅",
            "Every day is a new beginning 🌸",
            "Creating my own sunshine ☀️",
            "Lost in the beauty of nature 🍃",
            "Wandering where the WiFi is weak 📵",
            "Collecting moments, not things 💎",
            "Living in the moment 🎭",
            "Adventure is calling 📞",
            "Making today amazing! 🚀",
            "Blessed and grateful 🙌",
            "Finding joy in simple things 🌻",
            "Dream big, shine bright ⭐"
        ]
        
        return unsplashPhotos.enumerated().map { index, photo in
            Post(
                user: User(
                    userName: photo.user.username,
                    userImage: photo.user.profileImage.small
                ),
                postImage: photo.urls.regular,
                caption: inspirationalCaptions[index % inspirationalCaptions.count],
                likes: "\(photo.likes) likes"
            )
        }
    }
    
    private func loadFallbackData() {
        // Use static local fallback data when API is unavailable
        stories = LocalFallbackData.stories
        posts = LocalFallbackData.posts
        print("📱 Using local fallback data")
    }
    
    // MARK: - Pagination Methods
    
    func loadMorePosts() async {
        guard !isPaginating && canLoadMore else { return }
        
        isPaginating = true
        currentPage += 1
        
        if useLocalData {
            // Simulate pagination with local data
            await loadMoreLocalPosts()
        } else {
            // Load more posts from API
            await loadMorePostsFromAPI()
        }
        
        isPaginating = false
    }
    
    private func loadMoreLocalPosts() async {
        // Simulate API delay
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // Generate more posts using LocalPostProvider
        let newPosts = LocalPostProvider.generatePosts(count: postsPerPage)
        posts.append(contentsOf: newPosts)
        
        // Stop pagination after 5 pages (50 posts total) for local data
        if currentPage >= 5 {
            canLoadMore = false
        }
        
        print("📱 Loaded page \(currentPage) with \(newPosts.count) more posts (local data)")
    }
    
    private func loadMorePostsFromAPI() async {
        do {
            let queries = [
                "lifestyle photography",
                "urban exploration", 
                "nature landscape",
                "street photography",
                "travel adventure",
                "food photography",
                "portrait photography",
                "architecture design"
            ]
            
            let randomQuery = queries.randomElement() ?? "photography"
            
            let unsplashPhotos = try await unsplashService.searchPhotos(
                query: randomQuery,
                orientation: "squarish",
                count: postsPerPage
            )
            
            let inspirationalCaptions = [
                "New adventures await! 🌟",
                "Capturing life's beautiful moments 📸",
                "Every sunset brings promise of a new dawn 🌅",
                "Life is a collection of moments 💫",
                "Finding magic in ordinary days ✨",
                "Adventure mode: ON 🚀",
                "Creating memories one photo at a time 📷",
                "Blessed with another beautiful day 🙏",
                "Life's too short for ordinary moments 🎭",
                "Making every day count! 💎"
            ]
            
            let newPosts = unsplashPhotos.enumerated().map { index, photo in
                Post(
                    user: User(
                        userName: photo.user.username,
                        userImage: photo.user.profileImage.small
                    ),
                    postImage: photo.urls.regular,
                    caption: inspirationalCaptions[index % inspirationalCaptions.count],
                    likes: "\(photo.likes) likes"
                )
            }
            
            posts.append(contentsOf: newPosts)
            
            // Stop pagination after 10 pages (100 posts total) for API data
            if currentPage >= 10 {
                canLoadMore = false
            }
            
            print("🌐 Loaded page \(currentPage) with \(newPosts.count) more posts from API")
            
        } catch {
            print("⚠️ Failed to load more posts from API: \(error)")
            // Fallback to local posts for pagination
            await loadMoreLocalPosts()
        }
    }
    
    // MARK: - Public Methods for Manual Refresh
    
    func refreshData() async {
        // Reset pagination state
        currentPage = 1
        canLoadMore = true
        posts.removeAll()
        
        await loadData()
    }
    
    func forceUseFallbackData() {
        loadFallbackData()
    }
    
    // MARK: - Testing Methods
    
    func enableLocalDataMode() {
        useLocalData = true
        print("🧪 Local data mode enabled - will use fallback data on next load")
    }
    
    func disableLocalDataMode() {
        useLocalData = false
        print("🌐 API mode enabled - will use Unsplash API on next load")
    }
    
    func toggleDataMode() {
        useLocalData.toggle()
        let mode = useLocalData ? "Local" : "API"
        print("🔄 Switched to \(mode) mode")
    }
}
