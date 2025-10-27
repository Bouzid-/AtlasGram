//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation
import AVFoundation

struct LocalFallbackData {
    
    // MARK: - Static Data Properties
    static let stories: [Story] = LocalStoryProvider.generateStories()
    
    static let posts: [Post] = LocalPostProvider.generatePosts()
    
    static let activity: [Activity] = LocalActivityProvider.generateActivities()
    
    static let videos: [Video] = LocalVideoProvider.generateVideos()
    
    // MARK: - Dynamic Data Generation Methods
    static func generateFreshStories(count: Int = 16) -> [Story] {
        return LocalStoryProvider.generateMixedStories(count: count)
    }
    
    static func generateFreshPosts(count: Int = 8) -> [Post] {
        return LocalPostProvider.generatePosts(count: count)
    }
    
    static func generateFreshActivity(count: Int = 5) -> [Activity] {
        return LocalActivityProvider.generateActivities(count: count)
    }
    
    static func generateFreshVideos(count: Int = 7) -> [Video] {
        return LocalVideoProvider.generateVideos(count: count)
    }
    
    // MARK: - Themed Content Generation
    static func generateThemedContent() -> (stories: [Story], posts: [Post], activity: [Activity], videos: [Video]) {
        return (
            stories: LocalStoryProvider.generateMixedStories(),
            posts: [
                LocalPostProvider.generateTravelPost(),
                LocalPostProvider.generateCreativePost(),
                LocalPostProvider.generateLifestylePost(),
                LocalPostProvider.generateTravelPost(),
                LocalPostProvider.generateCreativePost(),
                LocalPostProvider.generateLifestylePost(),
                LocalPostProvider.generateTravelPost(),
                LocalPostProvider.generateCreativePost()
            ],
            activity: LocalActivityProvider.generateActivities(),
            videos: [
                LocalVideoProvider.generateTravelVideo(),
                LocalVideoProvider.generateCreativeVideo(),
                LocalVideoProvider.generateLifestyleVideo(),
                LocalVideoProvider.generateTravelVideo(),
                LocalVideoProvider.generateCreativeVideo(),
                LocalVideoProvider.generateLifestyleVideo(),
                LocalVideoProvider.generateTravelVideo()
            ]
        )
    }
}
