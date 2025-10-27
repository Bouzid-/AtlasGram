//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    var gradient = Gradient(colors: [.yellow, .red, .purple, .orange, .pink, .red])
    
    var body: some View {
        
        //Stories
        VStack {
            CircularRemoteImage(url: story.user.userImage, fallbackImageName: "user_1", size: 60)
                .overlay(Circle().stroke(LinearGradient( gradient: gradient, startPoint: .bottomLeading, endPoint: .topTrailing) , style: StrokeStyle(lineWidth: 2.5, lineCap: .round)))
                .padding([.top, .horizontal], 5)
            Text(story.user.userName)
                .truncationMode(.tail)
                .font(.caption2)
                .frame(width: 80, height: 15)
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(story: LocalFallbackData.stories.first!)
    }
}
