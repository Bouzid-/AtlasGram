//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation

struct LocalUserProvider {
    
    // MARK: - All Available Users
    static let allUsers: [User] = [
        User(userName: "sophie.wanderlust", userImage: "user_1"),
        User(userName: "alex.urban", userImage: "user_2"),
        User(userName: "maya.creative", userImage: "user_3"),
        User(userName: "noah.adventures", userImage: "user_4"),
        User(userName: "emma.lifestyle", userImage: "user_5"),
        User(userName: "liam.fitness", userImage: "user_6"),
        User(userName: "zoe.artistry", userImage: "user_7"),
        User(userName: "ethan.explorer", userImage: "user_8"),
        User(userName: "aria.moments", userImage: "user_9"),
        User(userName: "jake.travels", userImage: "user_10"),
        User(userName: "luna.photography", userImage: "user_11"),
        User(userName: "max.outdoor", userImage: "user_12"),
        User(userName: "chloe.vibes", userImage: "user_13"),
        User(userName: "ryan.journey", userImage: "user_14"),
        User(userName: "mia.dreams", userImage: "user_15"),
        User(userName: "oliver.captures", userImage: "user_16"),
        User(userName: "isabella.art", userImage: "user_17"),
        User(userName: "daniel.explorer", userImage: "user_18"),
        User(userName: "mason.creative", userImage: "user_19"),
        User(userName: "ava.lifestyle", userImage: "user_20")
    ]
    
    // MARK: - Random User Selection
    static func randomUser() -> User {
        return allUsers.randomElement() ?? allUsers[0]
    }
    
    static func randomUsers(count: Int) -> [User] {
        return Array(allUsers.shuffled().prefix(count))
    }
    
    // MARK: - Specific User Selection
    static func user(at index: Int) -> User {
        guard index < allUsers.count else {
            return allUsers[0] // Fallback to first user
        }
        return allUsers[index]
    }
    
    static func user(withUserName userName: String) -> User? {
        return allUsers.first { $0.userName == userName }
    }
    
    // MARK: - Themed User Groups
    static let travelUsers: [User] = [
        user(withUserName: "sophie.wanderlust")!,
        user(withUserName: "noah.adventures")!,
        user(withUserName: "jake.travels")!,
        user(withUserName: "ethan.explorer")!,
        user(withUserName: "daniel.explorer")!
    ]
    
    static let creativeUsers: [User] = [
        user(withUserName: "maya.creative")!,
        user(withUserName: "zoe.artistry")!,
        user(withUserName: "luna.photography")!,
        user(withUserName: "oliver.captures")!,
        user(withUserName: "isabella.art")!,
        user(withUserName: "mason.creative")!
    ]
    
    static let lifestyleUsers: [User] = [
        user(withUserName: "emma.lifestyle")!,
        user(withUserName: "chloe.vibes")!,
        user(withUserName: "aria.moments")!,
        user(withUserName: "ava.lifestyle")!
    ]
    
    // MARK: - Convenience Methods
    static func randomTravelUser() -> User {
        return travelUsers.randomElement() ?? travelUsers[0]
    }
    
    static func randomCreativeUser() -> User {
        return creativeUsers.randomElement() ?? creativeUsers[0]
    }
    
    static func randomLifestyleUser() -> User {
        return lifestyleUsers.randomElement() ?? lifestyleUsers[0]
    }
}
