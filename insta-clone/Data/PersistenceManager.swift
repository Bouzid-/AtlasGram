//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults = UserDefaults.standard
    private let likedPostsKey = "liked_posts"
    private let bookmarkedPostsKey = "bookmarked_posts"
    private let seenStoriesKey = "seen_stories"
    
    private init() {}
    
    // MARK: - Like Persistence
    
    func saveLikedPosts(_ likedPostIds: Set<String>) {
        let likedPostArray = Array(likedPostIds)
        userDefaults.set(likedPostArray, forKey: likedPostsKey)
    }
    
    func loadLikedPosts() -> Set<String> {
        guard let likedPostStrings = userDefaults.array(forKey: likedPostsKey) as? [String] else {
            return Set<String>()
        }
        
        return Set(likedPostStrings)
    }
    
    func addLikedPost(_ postId: String) {
        var likedPosts = loadLikedPosts()
        likedPosts.insert(postId)
        saveLikedPosts(likedPosts)
    }
    
    func removeLikedPost(_ postId: String) {
        var likedPosts = loadLikedPosts()
        likedPosts.remove(postId)
        saveLikedPosts(likedPosts)
    }
    
    func isPostLiked(_ postId: String) -> Bool {
        let likedPosts = loadLikedPosts()
        return likedPosts.contains(postId)
    }
    
    // MARK: - Bookmark Persistence
    
    func saveBookmarkedPosts(_ bookmarkedPostIds: Set<String>) {
        let bookmarkedPostArray = Array(bookmarkedPostIds)
        userDefaults.set(bookmarkedPostArray, forKey: bookmarkedPostsKey)
    }
    
    func loadBookmarkedPosts() -> Set<String> {
        guard let bookmarkedPostStrings = userDefaults.array(forKey: bookmarkedPostsKey) as? [String] else {
            return Set<String>()
        }
        
        return Set(bookmarkedPostStrings)
    }
    
    func addBookmarkedPost(_ postId: String) {
        var bookmarkedPosts = loadBookmarkedPosts()
        bookmarkedPosts.insert(postId)
        saveBookmarkedPosts(bookmarkedPosts)
    }
    
    func removeBookmarkedPost(_ postId: String) {
        var bookmarkedPosts = loadBookmarkedPosts()
        bookmarkedPosts.remove(postId)
        saveBookmarkedPosts(bookmarkedPosts)
    }
    
    func isPostBookmarked(_ postId: String) -> Bool {
        let bookmarkedPosts = loadBookmarkedPosts()
        return bookmarkedPosts.contains(postId)
    }
    
    // MARK: - Batch Operations
    
    func updatePostStates(for posts: inout [Post]) {
        let likedPosts = loadLikedPosts()
        let bookmarkedPosts = loadBookmarkedPosts()
        
        var updatedLikes = 0
        var updatedBookmarks = 0
        
        for i in 0..<posts.count {
            let wasLiked = posts[i].hasLiked
            let wasBookmarked = posts[i].hasBookmarked
            
            posts[i].hasLiked = likedPosts.contains(posts[i].id)
            posts[i].hasBookmarked = bookmarkedPosts.contains(posts[i].id)
            
            if posts[i].hasLiked != wasLiked {
                updatedLikes += 1
            }
            if posts[i].hasBookmarked != wasBookmarked {
                updatedBookmarks += 1
            }
        }
        
        if updatedLikes > 0 || updatedBookmarks > 0 {
            print("💾 Applied persistence: \(updatedLikes) likes, \(updatedBookmarks) bookmarks restored")
        }
    }
    
    // MARK: - Story Persistence
    
    func saveSeenStories(_ seenStoryIds: Set<String>) {
        let seenStoriesArray = Array(seenStoryIds)
        userDefaults.set(seenStoriesArray, forKey: seenStoriesKey)
    }
    
    func loadSeenStories() -> Set<String> {
        guard let seenStoriesStrings = userDefaults.array(forKey: seenStoriesKey) as? [String] else {
            return Set<String>()
        }
        
        return Set(seenStoriesStrings)
    }
    
    func addSeenStory(_ storyId: String) {
        var seenStories = loadSeenStories()
        seenStories.insert(storyId)
        saveSeenStories(seenStories)
    }
    
    func removeSeenStory(_ storyId: String) {
        var seenStories = loadSeenStories()
        seenStories.remove(storyId)
        saveSeenStories(seenStories)
    }
    
    func isStorySeen(_ storyId: String) -> Bool {
        let seenStories = loadSeenStories()
        return seenStories.contains(storyId)
    }
    
    func updateStoryStates(for stories: inout [Story]) {
        let seenStories = loadSeenStories()
        
        var updatedCount = 0
        
        for i in 0..<stories.count {
            let wasSeen = stories[i].hasSeen
            stories[i].hasSeen = seenStories.contains(stories[i].id.uuidString)
            
            if stories[i].hasSeen != wasSeen {
                updatedCount += 1
            }
        }
        
        if updatedCount > 0 {
            print("👁️ Applied story persistence: \(updatedCount) stories marked as seen")
        }
    }
    
    // MARK: - Clear Data (for testing/reset)
    
    func clearAllData() {
        userDefaults.removeObject(forKey: likedPostsKey)
        userDefaults.removeObject(forKey: bookmarkedPostsKey)
        userDefaults.removeObject(forKey: seenStoriesKey)
        userDefaults.synchronize()
        print("🗑️ Cleared all persistence data")
    }
    
    func resetAndValidateStorage() {
        // Clear any potentially corrupted data
        clearAllData()
        
        // Test with a sample string to ensure storage works
        let testSet: Set<String> = ["test-id-1", "test-id-2"]
        saveLikedPosts(testSet)
        
        let loadedSet = loadLikedPosts()
        if loadedSet == testSet {
            print("✅ Storage validation successful")
        } else {
            print("❌ Storage validation failed")
        }
        
        // Clear test data
        clearAllData()
    }
    
    // MARK: - Debug
    
    func printStoredData() {
        let likedPosts = loadLikedPosts()
        let bookmarkedPosts = loadBookmarkedPosts()
        let seenStories = loadSeenStories()
        
        print("📱 Persistence Manager State:")
        print("  Liked posts: \(likedPosts.count)")
        print("  Bookmarked posts: \(bookmarkedPosts.count)")
        print("  Seen stories: \(seenStories.count)")
        
        if !likedPosts.isEmpty {
            print("  Liked IDs: \(likedPosts)")
        }
        
        if !bookmarkedPosts.isEmpty {
            print("  Bookmarked IDs: \(bookmarkedPosts)")
        }
        
        if !seenStories.isEmpty {
            print("  Seen story IDs: \(seenStories)")
        }
    }
}
