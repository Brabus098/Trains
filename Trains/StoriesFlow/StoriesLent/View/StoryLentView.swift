import SwiftUI
import Combine

struct StoryLentView: View {
    
    var viewModel: StoriesLentViewModel
    @State private var timer: Timer.TimerPublisher?
    @State private var cancellable: Cancellable?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: viewModel.currentStory)
                .allowsHitTesting(true)
            
            ProgressBar(numberOfSections: viewModel.numberOfSections,
                        progress: viewModel.progress)
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            tapZone
            CloseButton(action: { viewModel.closeStories() })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
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
