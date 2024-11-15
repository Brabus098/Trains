import SwiftUI
import Combine

struct StoryLentView: View {
    
    // MARK: - Properties
    
    var viewModel: StoriesLentViewModel
    @State var showNewStory = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if showNewStory {
                StoryView(story: viewModel.currentStory)
                    .allowsHitTesting(true)
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
            }
            
            ProgressBar(numberOfSections: viewModel.numberOfSections,
                        progress: viewModel.progress)
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            tapZone
            CloseButton(action: { viewModel.closeStories() })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.2)) {
                showNewStory = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.startTimer()
            }
        }
        .onDisappear {
            viewModel.resetStories()
        }
    }
    
    // MARK: - Subviews
    
    private var tapZone: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.prevStory()
                }
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.nextStory()
                }
        }
    }
}
