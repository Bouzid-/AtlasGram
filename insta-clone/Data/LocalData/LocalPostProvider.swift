//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation

struct LocalPostProvider {
    
    // MARK: - Post Captions
    static let inspirationalCaptions = [
        "Just captured this amazing sunset moment! Sometimes the best stories are the ones we create ourselves 📸",
        "Lost in thought and found in nature. Every walk is a journey of discovery 🌿",
        "The mountains are calling and I must go. Adventure awaits at every turn! ⛰️",
        "Coffee, creativity, and good vibes. That's all I need to start my day right ☕✨",
        "Chasing waterfalls and finding peace in nature's symphony 🏞️",
        "Golden hour magic never gets old. Light is everything in photography 📷",
        "Wandering through ancient streets, collecting memories one step at a time 🗺️",
        "Dancing through life with gratitude in my heart. Every moment is a gift 💫",
        "Finding beauty in the simplest moments 🌸",
        "Life is an adventure, embrace every chapter 📖",
        "Creating my own sunshine on cloudy days ☀️",
        "Collecting experiences, not things 💎",
        "Every sunset brings the promise of a new dawn 🌅",
        "Living life in full color 🎨",
        "Making memories that will last forever 🌟",
        "The best views come after the hardest climbs 🏔️",
        "Grateful for this beautiful journey called life 🙏",
        "Finding magic in ordinary moments ✨",
        "Adventure is out there, you just have to look 🔍",
        "Blessed to witness another beautiful day 🌺"
    ]
    
    // MARK: - Post Generation
    static func generatePosts(count: Int = 8) -> [Post] {
        return (0..<count).map { index in
            Post(
                id: "post_\(index + 1)",
                user: LocalUserProvider.randomUser(),
                postImage: "post_\(index + 1)",
                caption: inspirationalCaptions[index % inspirationalCaptions.count],
                likes: "\(LocalUserProvider.randomUser().userName) and \(Int.random(in: 50...300)) others liked"
            )
        }
    }
    
    static func generatePost(index: Int) -> Post {
        return Post(
            id: "post_\(index + 1)",
            user: LocalUserProvider.randomUser(),
            postImage: "post_\(index)",
            caption: inspirationalCaptions[(index - 1) % inspirationalCaptions.count],
            likes: "\(LocalUserProvider.randomUser().userName) and \(Int.random(in: 50...300)) others liked"
        )
    }
    
    // MARK: - Themed Posts
    static func generateTravelPost() -> Post {
        let travelCaptions = [
            "The mountains are calling and I must go. Adventure awaits at every turn! ⛰️",
            "Wandering where the WiFi is weak 📵",
            "Adventure is out there, you just have to look 🔍",
            "Collecting passport stamps and memories 🌍"
        ]
        
        return Post(
            id: "post_ran_\(Int.random(in: 1...19))",
            user: LocalUserProvider.randomTravelUser(),
            postImage: "post_\(Int.random(in: 1...19))",
            caption: travelCaptions.randomElement() ?? travelCaptions[0],
            likes: "\(LocalUserProvider.randomUser().userName) and \(Int.random(in: 100...500)) others liked"
        )
    }
    
    static func generateCreativePost() -> Post {
        let creativeCaptions = [
            "Art is everywhere if you know how to look for it 🎨",
            "Creating my own sunshine on cloudy days ☀️",
            "Life is an adventure, embrace every chapter 📖",
            "Finding magic in ordinary moments ✨"
        ]
        
        return Post(
            id: "post_ran_\(Int.random(in: 1...19))",
            user: LocalUserProvider.randomCreativeUser(),
            postImage: "post_\(Int.random(in: 1...19))",
            caption: creativeCaptions.randomElement() ?? creativeCaptions[0],
            likes: "\(LocalUserProvider.randomUser().userName) and \(Int.random(in: 80...250)) others liked"
        )
    }
    
    static func generateLifestylePost() -> Post {
        let lifestyleCaptions = [
            "Coffee, creativity, and good vibes. That's all I need to start my day right ☕✨",
            "Finding beauty in the simplest moments 🌸",
            "Grateful for this beautiful journey called life 🙏",
            "Living life in full color 🎨"
        ]
        
        return Post(
            id: "post_ran_\(Int.random(in: 1...19))",
            user: LocalUserProvider.randomLifestyleUser(),
            postImage: "post_\(Int.random(in: 1...19))",
            caption: lifestyleCaptions.randomElement() ?? lifestyleCaptions[0],
            likes: "\(LocalUserProvider.randomUser().userName) and \(Int.random(in: 60...200)) others liked"
        )
    }
}
