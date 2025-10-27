//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Unsplash API Models
struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let urls: PhotoURLs
    let user: UnsplashUser
    let description: String?
    let altDescription: String?
    let likes: Int
    let width: Int
    let height: Int
}

struct PhotoURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct UnsplashUser: Codable {
    let id: String
    let username: String
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

// MARK: - Unsplash Service
class UnsplashService: ObservableObject {
    private let baseURL = "https://api.unsplash.com"
    private let accessKey = APIConfig.unsplashAccessKey
    
    func fetchPhotos(orientation: String = "portrait", count: Int = 20, query: String? = nil) async throws -> [UnsplashPhoto] {
        var components = URLComponents(string: "\(baseURL)/photos")!
        
        var queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
            URLQueryItem(name: "orientation", value: orientation),
            URLQueryItem(name: "per_page", value: String(count))
        ]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let photos = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
        return photos
    }
    
    func searchPhotos(query: String, orientation: String = "portrait", count: Int = 20) async throws -> [UnsplashPhoto] {
        var components = URLComponents(string: "\(baseURL)/search/photos")!
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "orientation", value: orientation),
            URLQueryItem(name: "per_page", value: String(count))
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let searchResult = try JSONDecoder().decode(UnsplashSearchResult.self, from: data)
        return searchResult.results
    }
}

struct UnsplashSearchResult: Codable {
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhoto]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
