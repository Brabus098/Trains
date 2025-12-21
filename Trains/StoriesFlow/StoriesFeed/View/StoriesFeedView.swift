//  StoriesFeed.swift

import SwiftUI

struct StoriesFeedView: View {
    
    // MARK: - Properties

    @Binding var hideTabBar: Bool
    @Binding var navigationPath: NavigationPath
    @State var viewModel: StoriesFeedViewModel
    @State var story: Story
    
    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView(.horizontal) {
                lentWithStories
            }
            .frame(maxHeight: 160)
            .scrollIndicators(.hidden)
            .onChange(of: viewModel.isCloseStories) { _, newValue in
                if newValue {
                    navigationPath.removeLast()
                }
            }
        }
    }
    
    // MARK: - Subviews

    private var lentWithStories: some View {
        LazyHStack(spacing: 10) {
            
            if let imageArray = viewModel.mainImageViewArray {
                ForEach(imageArray, id: \.self) { imageName in
                    StoriesCellView(storiesType: MainStoriesModel(image: imageName.image, borderStatus: imageName.borderStatus), textForImage: story)
                        .onTapGesture {
                            viewModel.tapOnStories(with: imageName.image)
                            navigationPath.append("Stories")
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}
