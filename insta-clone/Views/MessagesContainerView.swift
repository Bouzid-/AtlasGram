//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct MessagesContainerView: View {
    var body: some View {
        NavigationView {
            Text("Hello, Messages!")
                .applyMessagesNavigationBar()
        }
        .navigationBarHidden(true)
    }
}

struct MessagesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesContainerView()
    }
}
