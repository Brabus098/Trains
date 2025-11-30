//  StoriesFeed.swift

import SwiftUI

struct StoriesFeedView: View {
    
    @Binding var hideTabBar: Bool
    @Binding var navigationPath: NavigationPath
    @State var viewModel: StoriesViewModel
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView(.horizontal) {
                lentWithStories
            }
            .frame(maxHeight: 160)
            .scrollIndicators(.hidden)
            .onAppear {
                viewModel.createMainImageLent()
                viewModel.createDetailImageLent()
            }
            .onChange(of: viewModel.isCloseStories) { _, newValue in
                if newValue {
                    navigationPath.removeLast()
                    viewModel.isCloseStories.toggle()
                }
            }
        }
    }
    
    private var lentWithStories: some View {
        LazyHStack(spacing: 10) {
            
            if let imageArray = viewModel.mainImageViewArray {
                ForEach(imageArray, id: \.self) { imageName in
                    StoriesCellView(storiesType: MainStoriesModel(image: imageName.image, borderStatus: imageName.borderStatus))
                    .onTapGesture {
                        viewModel.createStoryArray(number: imageName.image)
                        navigationPath.append("Stories")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
