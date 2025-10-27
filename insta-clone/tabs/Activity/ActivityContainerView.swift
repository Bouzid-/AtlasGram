//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct ActivityContainerView: View {
    @StateObject private var dataProvider = DataProvider()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(dataProvider.activity) {
                    ActivityView(activity: $0)
                }
            }
            .applyActivityNavigationBar()
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityContainerView()
    }
}
