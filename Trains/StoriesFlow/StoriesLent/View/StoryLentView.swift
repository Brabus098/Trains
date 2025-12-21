import SwiftUI
import Combine

struct StoryLentView: View {
    
    // MARK: - Properties

    var viewModel: StoriesLentViewModel
    @State private var timer: Timer.TimerPublisher?
    @State private var cancellable: Cancellable?
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
            viewModel.setConfiguration()
            viewModel.createTimer()
            timer = viewModel.timer
            cancellable = timer?.connect()
            
            if timer == nil {
                timer = Timer.publish(every: 0.1, on: .main, in: .common)
                cancellable = timer?.connect()
            }
        }
        .onDisappear {
            cancellable?.cancel()
            cancellable = nil
            viewModel.resetStories()
        }
        .onReceive(timer?.autoconnect() ?? Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            viewModel.timerTick()
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
                    viewModel.resetTimer()
                }
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.nextStory()
                    viewModel.resetTimer()
                }
        }
    }
}
