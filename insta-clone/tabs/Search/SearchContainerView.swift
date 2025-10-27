//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct SearchContainerView: View {
    @StateObject private var dataProvider = DataProvider()
    private let searchStrings: [String] = []
    @State private var searchText : String = ""

    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, placeholder: "Search")
            if dataProvider.isLoading {
                ProgressView("Loading posts...")
                    .padding()
            } else {
                PostGridView(posts: dataProvider.posts)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContainerView()
    }
}
