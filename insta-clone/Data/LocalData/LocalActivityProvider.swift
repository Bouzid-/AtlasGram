//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation

struct LocalActivityProvider {
    
    // MARK: - Sample Activity Data
    static let sampleCaptions = [
        "Amazing shot!",
        "Great content!",
        "Beautiful photo!",
        "Lovely day!",
        "Perfect moment!",
        "Incredible view!",
        "So inspiring!",
        "Love this!",
        "Stunning capture!",
        "Absolutely gorgeous!"
    ]
    
    static let sampleComments = [
        "❤️🙏🏻",
        "🔥🔥🔥",
        "So beautiful! 😍",
        "Amazing work! 👏",
        "Love this vibe ✨",
        "Incredible! 🌟",
        "This is perfect! 💫",
        "Stunning! 📸",
        "Goals! 🙌",
        "Obsessed! 💕"
    ]
    
    static let durations = ["5m", "15m", "30m", "1h", "2h", "5h", "8h", "12h", "18h", "1d", "2d"]
    
    // MARK: - Activity Generation
    static func generateActivities(count: Int = 10) -> [Activity] {
        let mainUser = LocalUserProvider.randomCreativeUser()
        
        return (0..<count).map { index in
            generateActivity(for: mainUser, index: index)
        }
    }
    
    static func generateActivity(for mainUser: User, index: Int) -> Activity {
        let activityTypes: [ActivityType] = [.liked, .newFollower, .comment, .suggestFollower]
        let activityType = activityTypes[index % activityTypes.count]
        
        let usersInContext: [User]
        let comment: String
        
        switch activityType {
        case .liked:
            usersInContext = LocalUserProvider.randomUsers(count: Int.random(in: 1...3))
            comment = ""
            
        case .newFollower:
            usersInContext = [LocalUserProvider.randomUser()]
            comment = ""
            
        case .comment:
            usersInContext = [LocalUserProvider.randomUser()]
            comment = "@\(mainUser.userName) \(sampleComments.randomElement() ?? sampleComments[0])"
            
        case .suggestFollower:
            usersInContext = [LocalUserProvider.randomUser()]
            comment = ""
        }
        
        return Activity(
            activity: activityType,
            duration: durations.randomElement() ?? durations[0],
            usersInContext: usersInContext,
            post: Post(
                user: mainUser,
                postImage: "post_\(Int.random(in: 1...19))",
                caption: sampleCaptions.randomElement() ?? sampleCaptions[0],
                likes: "\(LocalUserProvider.randomUser().userName) and others liked"
            ),
            comment: comment
        )
    }
    
    // MARK: - Specific Activity Types
    static func generateLikeActivity(for user: User? = nil) -> Activity {
        let mainUser = user ?? LocalUserProvider.randomUser()
        
        return Activity(
            activity: .liked,
            duration: durations.randomElement() ?? "15m",
            usersInContext: LocalUserProvider.randomUsers(count: Int.random(in: 1...3)),
            post: Post(
                user: mainUser,
                postImage: "post_\(Int.random(in: 1...19))",
                caption: sampleCaptions.randomElement() ?? sampleCaptions[0],
                likes: "\(LocalUserProvider.randomUser().userName) and others liked"
            )
        )
    }
    
    static func generateFollowerActivity(for user: User? = nil) -> Activity {
        let mainUser = user ?? LocalUserProvider.randomUser()
        
        return Activity(
            activity: .newFollower,
            duration: durations.randomElement() ?? "2h",
            usersInContext: [LocalUserProvider.randomUser()],
            post: Post(
                user: mainUser,
                postImage: "post_\(Int.random(in: 1...19))",
                caption: sampleCaptions.randomElement() ?? sampleCaptions[0],
                likes: "\(LocalUserProvider.randomUser().userName) and others liked"
            ),
            comment: ""
        )
    }
    
    static func generateCommentActivity(for user: User? = nil) -> Activity {
        let mainUser = user ?? LocalUserProvider.randomUser()
        
        return Activity(
            activity: .comment,
            duration: durations.randomElement() ?? "1h",
            usersInContext: [LocalUserProvider.randomUser()],
            post: Post(
                user: mainUser,
                postImage: "post_\(Int.random(in: 1...19))",
                caption: sampleCaptions.randomElement() ?? sampleCaptions[0],
                likes: "\(LocalUserProvider.randomUser().userName) and others liked"
            ),
            comment: "@\(mainUser.userName) \(sampleComments.randomElement() ?? sampleComments[0])"
        )
    }
}
