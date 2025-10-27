//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct NavigationBarComponents {
    
    // MARK: - Navigation Bar Title Configurations
    static func inlineTitle(_ title: String = "") -> some View {
        EmptyView()
            .navigationBarTitle(title, displayMode: .inline)
    }
    
    static func largeTitle(_ title: String) -> some View {
        EmptyView()
            .navigationBarTitle(title, displayMode: .large)
    }
    
    // MARK: - Generic Navigation Bar Configurations
    
    static func titleOnlyNavigationBar(title: String, displayMode: NavigationBarItem.TitleDisplayMode = .inline) -> some View {
        EmptyView()
            .navigationBarTitle(title, displayMode: displayMode)
    }
    
    static func customNavigationBar<Content: View>(
        title: String = "",
        displayMode: NavigationBarItem.TitleDisplayMode = .inline,
        @ViewBuilder toolbarContent: () -> Content
    ) -> some View {
        EmptyView()
            .navigationBarTitle(title, displayMode: displayMode)
            .toolbar(content: toolbarContent)
    }
    
    static func standardNavigationBar<Leading: View, Trailing: View>(
        title: String = "",
        displayMode: NavigationBarItem.TitleDisplayMode = .inline,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) -> some View {
        EmptyView()
            .navigationBarTitle(title, displayMode: displayMode)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    leading()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailing()
                }
            })
    }
}

// MARK: - View Extension for Easy Usage
extension View {
    func applyTimelineNavigationBar() -> some View {
        self.modifier(NavigationBarModifier(configuration: .timeline))
    }
    
    func applyProfileNavigationBar(title: String = "Atlas Instagram") -> some View {
        self.modifier(NavigationBarModifier(configuration: .profile(title: title)))
    }
    
    func applyMessagesNavigationBar(username: String = "Atlas Instagram") -> some View {
        self.modifier(NavigationBarModifier(configuration: .messages(username: username)))
    }
    
    func applyActivityNavigationBar() -> some View {
        self.modifier(NavigationBarModifier(configuration: .activity))
    }
}

// MARK: - Navigation Bar Modifier
struct NavigationBarModifier: ViewModifier {
    enum Configuration {
        case timeline
        case profile(title: String)
        case messages(username: String)
        case activity
    }
    
    let configuration: Configuration
    
    func body(content: Content) -> some View {
        switch configuration {
        case .timeline:
            content
                .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    ToolbarComponents.timelineLeadingItem()
                    ToolbarComponents.timelineTrailingItem()
                })
        case .profile(let title):
            content
                .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    ToolbarComponents.profileLeadingItem(title: title)
                    ToolbarComponents.profileTrailingItem()
                })
        case .messages(let username):
            content
                .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    ToolbarComponents.messagesLeadingItem(username: username)
                    ToolbarComponents.messagesTrailingItem()
                })
        case .activity:
            content
                .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    Text("Activity")
                        .font(Font.system(size: 20, weight: .bold))
                        .padding()
                        .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                })
        }
    }
}
