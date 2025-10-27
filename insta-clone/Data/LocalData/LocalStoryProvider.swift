//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation

struct LocalStoryProvider {
    
    // MARK: - Story Generation
    static func generateStories(count: Int = 16) -> [Story] {
        let users = LocalUserProvider.allUsers.prefix(count)
        
        return users.map { user in
            Story(
                user: user,
                hasSeen: Bool.random(), // Random seen status for variety
                isMyStory: false
            )
        }
    }
    
    static func generateStoriesWithRandomUsers(count: Int = 16) -> [Story] {
        let randomUsers = LocalUserProvider.randomUsers(count: count)
        
        return randomUsers.map { user in
            Story(
                user: user,
                hasSeen: Bool.random(),
                isMyStory: false
            )
        }
    }
    
    // MARK: - Themed Stories
    static func generateTravelStories(count: Int = 5) -> [Story] {
        let travelUsers = Array(LocalUserProvider.travelUsers.prefix(count))
        
        return travelUsers.map { user in
            Story(
                user: user,
                hasSeen: Bool.random(),
                isMyStory: false
            )
        }
    }
    
    static func generateCreativeStories(count: Int = 6) -> [Story] {
        let creativeUsers = Array(LocalUserProvider.creativeUsers.prefix(count))
        
        return creativeUsers.map { user in
            Story(
                user: user,
                hasSeen: Bool.random(),
                isMyStory: false
            )
        }
    }
    
    static func generateLifestyleStories(count: Int = 4) -> [Story] {
        let lifestyleUsers = Array(LocalUserProvider.lifestyleUsers.prefix(count))
        
        return lifestyleUsers.map { user in
            Story(
                user: user,
                hasSeen: Bool.random(),
                isMyStory: false
            )
        }
    }
    
    // MARK: - Mixed Story Collections
    static func generateMixedStories(count: Int = 16) -> [Story] {
        var stories: [Story] = []
        
        // Add travel stories
        stories.append(contentsOf: generateTravelStories(count: min(5, count)))
        
        // Add creative stories
        let remainingCount = count - stories.count
        if remainingCount > 0 {
            stories.append(contentsOf: generateCreativeStories(count: min(6, remainingCount)))
        }
        
        // Add lifestyle stories
        let stillRemaining = count - stories.count
        if stillRemaining > 0 {
            stories.append(contentsOf: generateLifestyleStories(count: min(4, stillRemaining)))
        }
        
        // Fill remaining with random users
        let finalRemaining = count - stories.count
        if finalRemaining > 0 {
            let randomUsers = LocalUserProvider.randomUsers(count: finalRemaining)
            let randomStories = randomUsers.map { user in
                Story(user: user, hasSeen: Bool.random(), isMyStory: false)
            }
            stories.append(contentsOf: randomStories)
        }
        
        return Array(stories.shuffled().prefix(count))
    }
    
    // MARK: - Special Stories
    static func generateMyStory() -> Story {
        return Story(
            user: LocalUserProvider.user(at: 0), // Use first user as "my" story
            hasSeen: false,
            isMyStory: true
        )
    }
    
    static func generateStoriesWithMyStory(count: Int = 15) -> [Story] {
        var stories = [generateMyStory()]
        stories.append(contentsOf: generateStories(count: count))
        return stories
    }
    
    // MARK: - Utility Methods
    static func markAllAsSeen(_ stories: [Story]) -> [Story] {
        return stories.map { story in
            var updatedStory = story
            updatedStory.hasSeen = true
            return updatedStory
        }
    }
    
    static func markAllAsUnseen(_ stories: [Story]) -> [Story] {
        return stories.map { story in
            var updatedStory = story
            updatedStory.hasSeen = false
            return updatedStory
        }
    }
}
