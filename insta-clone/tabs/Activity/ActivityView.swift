//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    
    let activity: Activity
    
    var body: some View {
        HStack {
            Image(activity.usersInContext.first!.userImage)
                .resizable()
                .cornerRadius(20)
                .frame(width: 40, height: 40, alignment: .center)
                .clipped()

            if activity.activity == .liked {
                Text(activity.getUsernames())
                    .font(Font.system(size: 12, weight: .semibold)) +
                    Text(activity.usersInContext.count == 1 ? " liked your post. " : " and others liked your post. ")
                    .font(Font.system(size: 12, weight: .medium)) +
                    Text(activity.duration)
                    .font(Font.system(size: 10, weight: .light))
            } else if activity.activity == .comment {
                Text(activity.getUsernames())
                    .font(Font.system(size: 12, weight: .semibold)) +
                    Text(" mentioned you in a comment: ")
                    .font(Font.system(size: 12, weight: .medium)) +
                    Text((activity.comment))
                    .font(Font.system(size: 12, weight: .semibold)) +
                    Text(" " + activity.duration)
                    .font(Font.system(size: 10, weight: .light))
            }
            else if activity.activity == .suggestFollower {
                Text(activity.getUsernames())
                    .font(Font.system(size: 12, weight: .semibold)) +
                    Text(" who you might know, is on Instagram. ")
                    .font(Font.system(size: 12, weight: .medium)) +
                    Text(activity.duration)
                    .font(Font.system(size: 10, weight: .light))
            }
            else if activity.activity == .newFollower {
                Text(activity.getUsernames())
                    .font(Font.system(size: 12, weight: .semibold)) +
                    Text(" started following you. ")
                    .font(Font.system(size: 12, weight: .medium)) +
                    Text(activity.duration)
                    .font(Font.system(size: 10, weight: .light))
            }
            
            Spacer()
            
            if activity.activity == .suggestFollower {
                
                Button(action: {
                    
                }) {
                    HStack {
                        Spacer()
                        Text("Follow")
                            .font(Font.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .clipped()
                        Spacer()
                    }
                }
                .padding()
                .background(Color.blue)
                .frame(width: 100, height: 30, alignment: .center)
                .clipped()
                .cornerRadius(6)
            } else if activity.activity == .newFollower {
                Button("Following") {
                    print("Follow button clicked.")
                }
                .font(Font.system(size: 14, weight: .semibold))
                .padding()
                .foregroundColor(.primary)
                .cornerRadius(6)
                .overlay(RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.primary, lineWidth: 0.2).frame(height: 28, alignment: .center))
                .frame(width: 100, height: 30, alignment: .center)
            } else {
                Image(activity.post.postImage)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipped()
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}
