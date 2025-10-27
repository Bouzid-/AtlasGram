//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct ProfileContainerView: View {
    @StateObject private var dataProvider = DataProvider()
    private let user: User = LocalUserProvider.randomUser()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ProfileHeader(user: user)
                    ProfileControlButtonsView()
                    ProfileMediaSelectionView()
                    if dataProvider.isLoading {
                        ProgressView("Loading posts...")
                            .padding()
                    } else {
                        PostGridView(posts: dataProvider.posts)
                    }
                }
            }
            .applyProfileNavigationBar()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileContainerView()
        }
    }
}
