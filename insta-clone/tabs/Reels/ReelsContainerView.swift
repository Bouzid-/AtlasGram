//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI
import AVKit

struct ReelsContainerView: View {
    @StateObject private var dataProvider = DataProvider()
    @State private var index = 0
    @State private var top = 0
    
    var body: some View{
        ZStack{
            PlayerPageView(videos: .constant(dataProvider.videos))
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsContainerView()
    }
}
