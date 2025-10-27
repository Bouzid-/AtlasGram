//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct ToolbarComponents {
    
    // MARK: - Timeline Toolbar Items
    static func timelineLeadingItem() -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Image("atlasgram")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 130)
        }
    }
    
    static func timelineTrailingItem() -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Image(systemName: "plus.app")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
                NavigationLink(destination: MessagesContainerView()) {
                    Image(systemName: "message")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
    
    // MARK: - Profile Toolbar Items
    static func profileLeadingItem(title: String = "Atlas Instagram") -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Text(title)
                .font(Font.system(size: 20, weight: .bold))
                .padding()
                .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
        }
    }
    
    static func profileTrailingItem() -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Image(systemName: "plus.app")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
                Image(systemName: "line.horizontal.3")
                    .resizable()
                    .frame(width: 25, height: 20)
            }
        }
    }
    
    // MARK: - Messages Toolbar Items
    static func messagesLeadingItem(username: String = "Atlas Instagram") -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Text(username)
                .font(Font.system(size: 20, weight: .bold))
                .padding()
                .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
        }
    }
    
    static func messagesTrailingItem() -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Image(systemName: "video")
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 20))
                    .padding(.trailing, 10)
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 20))
            }
        }
    }
    
    // MARK: - Generic Toolbar Items (for reusability)
    static func leadingTitleItem(title: String) -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Text(title)
                .font(Font.system(size: 20, weight: .bold))
                .padding()
        }
    }
    
    static func trailingIconItem(systemName: String, size: CGFloat = 25) -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: systemName)
                .resizable()
                .frame(width: size, height: size)
        }
    }
    
    static func trailingMultiIconItem(icons: [(systemName: String, size: CGFloat)]) -> ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                ForEach(0..<icons.count, id: \.self) { index in
                    let icon = icons[index]
                    Image(systemName: icon.systemName)
                        .resizable()
                        .frame(width: icon.size, height: icon.size)
                        .padding(.trailing, index < icons.count - 1 ? 10 : 0)
                }
            }
        }
    }
}
