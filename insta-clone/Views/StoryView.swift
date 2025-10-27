//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    let onStoryTapped: ((Story) -> Void)?
    
    // Different gradients for seen/unseen stories
    private var unseenGradient = Gradient(colors: [.yellow, .red, .purple, .orange, .pink, .red])
    private var seenGradient = Gradient(colors: [.gray.opacity(0.5), .gray.opacity(0.3)])
    
    var body: some View {
        
        //Stories
        VStack {
            CircularRemoteImage(url: story.user.userImage, fallbackImageName: "user_1", size: 60)
                .overlay(
                    Circle().stroke(
                        LinearGradient(
                            gradient: story.hasSeen ? seenGradient : unseenGradient,
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        ),
                        style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
                    )
                )
                .padding([.top, .horizontal], 5)
                .onTapGesture {
                    onStoryTapped?(story)
                }
            
            Text(story.user.userName)
                .truncationMode(.tail)
                .font(.caption2)
                .foregroundColor(story.hasSeen ? .gray : .primary)
                .frame(width: 80, height: 15)
        }
    }
    
    init(story: Story, onStoryTapped: ((Story) -> Void)? = nil) {
        self.story = story
        self.onStoryTapped = onStoryTapped
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(story: LocalFallbackData.stories.first!)
    }
}
