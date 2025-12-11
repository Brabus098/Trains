//  StoriesLentViewModel.swift

import SwiftUI
import Combine

@MainActor @Observable final class StoriesLentViewModel {
    
    private let service: StoriesService
    private var cancelLables = Set<AnyCancellable>()
    private var currentStoryGlobalIndex: Int = 0
    private var isReady = false
    private var stories: [[Story]] = []

    var configuration: StoryLentConfiguration?
    var timer: Timer.TimerPublisher?
    var progress: CGFloat = 0
    var cancellable: Cancellable?
    
    var currentStory: Story {
        guard !stories.isEmpty,
              currentStoryGlobalIndex < stories.count,
              !stories[currentStoryGlobalIndex].isEmpty else {
            return Story(image: "NoInternetError")
        }
        let index = currentStoryIndex
        
        guard index < stories[currentStoryGlobalIndex].count else {
            return stories[currentStoryGlobalIndex].first ?? Story(image: "NoInternetError")
        }
        
        return stories[currentStoryGlobalIndex][index]
    }
    
    private var currentStoryIndex: Int {
        guard !stories.isEmpty, currentStoryGlobalIndex < stories.count else {
            return 0
        }
        let count = stories[currentStoryGlobalIndex].count
        let calculated = Int(progress * CGFloat(count))
        return calculated
    }
    
    var numberOfSections: Int {
        guard !stories.isEmpty, currentStoryGlobalIndex < stories.count else {
            return 1
        }
        let count = stories[currentStoryGlobalIndex].count
        return count
    }
    
    init(service: StoriesService) {
        self.service = service
        addSubscribing()
    }
    
    func addSubscribing() {
        service.actualStoryPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newStoryArray in
                if let newStoryArray, !newStoryArray.isEmpty {
                    self?.stories = newStoryArray
                    self?.currentStoryGlobalIndex = 0
                    self?.progress = 0
                    self?.isReady = true
                    self?.setConfiguration()
                    self?.createTimer()
                } else {
                    self?.isReady = false
                }
            }
            .store(in: &cancelLables)
    }
    
    func nextStory() {
        let storiesCount = stories[currentStoryGlobalIndex].count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        
        if nextStoryIndex == 0 && currentStoryIndex != 0 && currentStoryGlobalIndex < stories.count - 1 {
            changeStatus(index: currentStoryGlobalIndex)
            currentStoryGlobalIndex += 1
        } else if nextStoryIndex == 0 && currentStoryIndex != 0 && currentStoryGlobalIndex == stories.count - 1 {
            changeStatus(index: currentStoryGlobalIndex)
            closeStories()
        } else if currentStoryGlobalIndex + 1 >= stories.count - 1 && storiesCount == 1 {
            changeStatus(index: currentStoryGlobalIndex)
            closeStories()
        }
        progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
    }
    
    func prevStory() {
        let storiesCount = stories[currentStoryGlobalIndex].count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let prevStoryIndex = currentStoryIndex - 1 > 0 ? currentStoryIndex - 1 : 0
        
        progress = CGFloat(prevStoryIndex) / CGFloat(storiesCount)
        
        if currentStoryIndex > 0 {
        } else if currentStoryIndex <= 0  && currentStoryGlobalIndex > 0 {
            currentStoryGlobalIndex -= 1
        } else if currentStoryIndex == 0 && currentStoryGlobalIndex == 0 {
            service.needUpdateActualStory(globalNumber: currentStoryGlobalIndex)
        }
    }
    
    func closeStories() {
        service.needClose()
    }
    
    func changeStatus(index: Int) {
        service.changeStatusFor(story: index)
    }
    
    func resetStories() {
        service.closeStoriesIfNeed()
    }
    
    func setConfiguration() {
        configuration = StoryLentConfiguration(storiesCount: stories.count)
    }
    
    func createTimer() {
        if let configuration {
            timer = Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
        }
    }
    
    func timerTick() {
        guard isReady else { return }
        guard let config = configuration else { return }
        
        var nextProgress = progress + config.progressPerTick
        
        if nextProgress >= 1 {
            nextProgress = 0
            if currentStoryGlobalIndex < stories.count - 1 {
                changeStatus(index: currentStoryGlobalIndex)
                currentStoryGlobalIndex += 1
            } else {
                changeStatus(index: currentStoryGlobalIndex)
                closeStories()
            }
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    func resetTimer() {
        cancellable?.cancel()
        createTimer()
        cancellable = timer?.connect()
    }
}
