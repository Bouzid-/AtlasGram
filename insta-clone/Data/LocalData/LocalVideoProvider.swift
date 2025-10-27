//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation
import AVFoundation

struct LocalVideoProvider {
    
    // MARK: - Video Captions
    static let videoCaptions = [
        "Living my best life one adventure at a time! ✨🌟",
        "City vibes hit different when you're chasing your dreams 🏙️💫",
        "Art is everywhere if you know how to look for it 🎨✨",
        "Every mountain climbed is a story worth telling 🏔️🌟",
        "Dancing through life with endless gratitude 💃✨",
        "Wanderlust mode: always on! Where to next? 🌍✈️",
        "Capturing moments that matter, one frame at a time 📸🌅",
        "Life is a beautiful adventure, embrace every moment 🦋",
        "Creating memories that will last forever 💫",
        "Finding magic in the everyday 🌈✨",
        "Adventure is calling, and I must go! 📞🏔️",
        "Living life in full color 🎨🌟",
        "Making today amazing, one moment at a time 🚀",
        "Blessed to witness this beautiful world 🙏🌍",
        "Chasing sunsets and dreams 🌅💭"
    ]
    
    // MARK: - Video Metrics
    static let likeCounts = [
        "1.2M", "981k", "74k", "6.2M", "289k", "52M", "17M",
        "2.4M", "156k", "3.8M", "945k", "12M", "678k", "8.9M", "445k"
    ]
    
    static let commentCounts = [
        "8.9k", "2.1k", "543", "10.1k", "1.2k", "1M", "2k",
        "15.3k", "892", "23.4k", "5.6k", "89k", "1.8k", "45.2k", "923"
    ]
    
    // MARK: - Video Generation
    static func generateVideos(count: Int = 7) -> [Video] {
        return (0..<count).map { index in
            generateVideo(index: index + 1)
        }
    }
    
    static func generateVideo(index: Int) -> Video {
        guard let videoPath = Bundle.main.path(forResource: "reel_\(index)", ofType: "mp4") else {
            // Fallback video if specific reel doesn't exist
            let fallbackPath = Bundle.main.path(forResource: "reel_1", ofType: "mp4") ?? ""
            return Video(
                player: AVPlayer(url: URL(fileURLWithPath: fallbackPath)),
                likes: likeCounts.randomElement() ?? "100k",
                comments: commentCounts.randomElement() ?? "1k",
                caption: videoCaptions.randomElement() ?? "Amazing moment!",
                user: LocalUserProvider.randomUser()
            )
        }
        
        return Video(
            player: AVPlayer(url: URL(fileURLWithPath: videoPath)),
            likes: likeCounts[(index - 1) % likeCounts.count],
            comments: commentCounts[(index - 1) % commentCounts.count],
            caption: videoCaptions[(index - 1) % videoCaptions.count],
            user: LocalUserProvider.randomUser()
        )
    }
    
    // MARK: - Themed Videos
    static func generateTravelVideo() -> Video {
        let travelCaptions = [
            "Wanderlust mode: always on! Where to next? 🌍✈️",
            "Every mountain climbed is a story worth telling 🏔️🌟",
            "Adventure is calling, and I must go! 📞🏔️",
            "Living my best life one adventure at a time! ✨🌟"
        ]
        
        let videoPath = Bundle.main.path(forResource: "reel_\(Int.random(in: 1...7))", ofType: "mp4") ?? ""
        
        return Video(
            player: AVPlayer(url: URL(fileURLWithPath: videoPath)),
            likes: likeCounts.randomElement() ?? "500k",
            comments: commentCounts.randomElement() ?? "2k",
            caption: travelCaptions.randomElement() ?? travelCaptions[0],
            user: LocalUserProvider.randomTravelUser()
        )
    }
    
    static func generateCreativeVideo() -> Video {
        let creativeCaptions = [
            "Art is everywhere if you know how to look for it 🎨✨",
            "Capturing moments that matter, one frame at a time 📸🌅",
            "Creating memories that will last forever 💫",
            "Finding magic in the everyday 🌈✨"
        ]
        
        let videoPath = Bundle.main.path(forResource: "reel_\(Int.random(in: 1...7))", ofType: "mp4") ?? ""
        
        return Video(
            player: AVPlayer(url: URL(fileURLWithPath: videoPath)),
            likes: likeCounts.randomElement() ?? "300k",
            comments: commentCounts.randomElement() ?? "1.5k",
            caption: creativeCaptions.randomElement() ?? creativeCaptions[0],
            user: LocalUserProvider.randomCreativeUser()
        )
    }
    
    static func generateLifestyleVideo() -> Video {
        let lifestyleCaptions = [
            "Living life in full color 🎨🌟",
            "Dancing through life with endless gratitude 💃✨",
            "Making today amazing, one moment at a time 🚀",
            "Blessed to witness this beautiful world 🙏🌍"
        ]
        
        let videoPath = Bundle.main.path(forResource: "reel_\(Int.random(in: 1...7))", ofType: "mp4") ?? ""
        
        return Video(
            player: AVPlayer(url: URL(fileURLWithPath: videoPath)),
            likes: likeCounts.randomElement() ?? "250k",
            comments: commentCounts.randomElement() ?? "800",
            caption: lifestyleCaptions.randomElement() ?? lifestyleCaptions[0],
            user: LocalUserProvider.randomLifestyleUser()
        )
    }
    
    // MARK: - Random Video Generation
    static func randomVideo() -> Video {
        return generateVideo(index: Int.random(in: 1...7))
    }
    
    static func randomVideos(count: Int) -> [Video] {
        return (0..<count).map { _ in randomVideo() }
    }
}
