//  StoriesFeed.swift

import SwiftUI

struct StoriesFeedView: View {
    let imageViewArray = ["1","2","3","4","5"]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(imageViewArray, id: \.self) { imageName in
                    StoriesCellView(imageName: imageName)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 160)
        .scrollIndicators(.hidden)
    }
}
