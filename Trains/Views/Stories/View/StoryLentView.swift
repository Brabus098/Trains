//  StoryLentView.swift

import SwiftUI
import Combine

struct StoryLentView: View {

    private let stories: [[Story]]
    private var viewModel: StoriesViewModel
    private let configuration: StoryLentConfiguration
    
    private var currentStory: Story { stories[currentStoryGlobalIndex][currentStoryIndex] } // выбранная история
    private var currentStoryIndex: Int { Int(progress * CGFloat(stories[currentStoryGlobalIndex].count)) } // номер выбранной стории
    @State private var currentStoryGlobalIndex: Int = 0 // индекс глобальной истории
    
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    init(stories: [[Story]], viewModel: StoriesViewModel) {
        self.stories = stories
        self.viewModel = viewModel
        configuration = StoryLentConfiguration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
                .allowsHitTesting(true)
            ProgressBar(numberOfSections: stories[currentStoryGlobalIndex].count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            tapZone
            CloseButton(action: { viewModel.needClose() })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
    }
    
    private var tapZone: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    prevStory()
                    resetTimer()
                }
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    nextStory()
                    resetTimer()
                }
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
            if currentStoryGlobalIndex < stories.count - 1 {
                viewModel.changeStatusFor(story: currentStoryGlobalIndex)
                currentStoryGlobalIndex += 1
            } else {
                viewModel.changeStatusFor(story: currentStoryGlobalIndex)
                viewModel.needClose()
            }
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func nextStory() {
        let storiesCount = stories[currentStoryGlobalIndex].count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        
        if nextStoryIndex == 0 && currentStoryIndex != 0 && currentStoryGlobalIndex < stories.count - 1 {
            viewModel.changeStatusFor(story: currentStoryGlobalIndex)
            currentStoryGlobalIndex += 1
        } else if nextStoryIndex == 0 && currentStoryIndex != 0 && currentStoryGlobalIndex == stories.count - 1 {
            viewModel.changeStatusFor(story: currentStoryGlobalIndex)
            viewModel.needClose()
        } else if currentStoryGlobalIndex + 1 >= stories.count - 1 && storiesCount == 1 {
            viewModel.changeStatusFor(story: currentStoryGlobalIndex)
            viewModel.needClose()
        }
        
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func prevStory() {
        let storiesCount = stories[currentStoryGlobalIndex].count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let prevStoryIndex = currentStoryIndex - 1 > 0 ? currentStoryIndex - 1 : 0
        
        withAnimation {
            progress = CGFloat(prevStoryIndex) / CGFloat(storiesCount)
        }
        
        if currentStoryIndex > 0 {
        } else if currentStoryIndex <= 0  && currentStoryGlobalIndex > 0 {
            currentStoryGlobalIndex -= 1
        } else if currentStoryIndex == 0 && currentStoryGlobalIndex == 0 {
            viewModel.needUpdateActualStory(globalNumber: currentStoryGlobalIndex)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: StoryLentConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
