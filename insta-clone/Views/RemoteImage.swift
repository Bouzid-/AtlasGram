//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct RemoteImage: View {
    let url: String
    let fallbackImageName: String?
    
    private var isLocalAsset: Bool {
        // Check if it's a local asset (doesn't start with http/https and doesn't contain /)
        !url.hasPrefix("http") && !url.contains("/")
    }
    
    var body: some View {
        if isLocalAsset {
            // Use local asset directly
            Image(url)
                .resizable()
                .scaledToFill()
        } else {
            // Use AsyncImage for remote URLs
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                if let fallbackImageName = fallbackImageName {
                    Image(fallbackImageName)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            ProgressView()
                                .scaleEffect(0.8)
                        }
                }
            }
        }
    }
}

struct CircularRemoteImage: View {
    let url: String
    let fallbackImageName: String?
    let size: CGFloat
    
    private var isLocalAsset: Bool {
        // Check if it's a local asset (doesn't start with http/https and doesn't contain /)
        !url.hasPrefix("http") && !url.contains("/")
    }
    
    var body: some View {
        if isLocalAsset {
            // Use local asset directly
            Image(url)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            // Use AsyncImage for remote URLs
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } placeholder: {
                if let fallbackImageName = fallbackImageName {
                    Image(fallbackImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .opacity(0.3)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: size, height: size)
                        .overlay {
                            ProgressView()
                                .scaleEffect(0.5)
                        }
                }
            }
        }
    }
}
