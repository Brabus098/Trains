import SwiftUI
import Combine

@MainActor @Observable final class StoriesLentViewModel {
    
    // MARK: - Properties
    
    private let service: StoriesService
    private var cancelLables = Set<AnyCancellable>()
    private var currentStoryGlobalIndex: Int = 0
    private var isReady = false
    private var stories: [[Story]] = []
    
    // Таймер
    private var timer: Timer?
    private var isTimerActive = false
    
    var configuration: StoryLentConfiguration?
    var progress: CGFloat = 0
    
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
        return min(calculated, count - 1)
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
        configuration = StoryLentConfiguration()
    }
    
    // MARK: - Methods
    
    func addSubscribing() {
        service.actualStoryPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newStoryArray in
                if let newStoryArray, !newStoryArray.isEmpty {
                    self?.stories = newStoryArray
                    self?.currentStoryGlobalIndex = 0
                    self?.progress = 0
                    self?.isReady = true
                } else {
                    self?.isReady = false
                    self?.stopTimer()
                }
            }
            .store(in: &cancelLables)
    }
    
    func closeStories() {
        stopTimer()
        service.needClose()
    }
    
    func changeStoriesStatus(index: Int) {
        service.changeStatusForViewedStories(story: index)
    }
    
    func resetStories() {
        stopTimer()
        service.closeStoriesIfNeed()
    }
}

// Stories navigation
extension StoriesLentViewModel {
    func nextStory() {
        stopTimer()
        
        let storiesCount = stories[currentStoryGlobalIndex].count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        
        withAnimation(.easeInOut(duration: 0.3)) {
            if nextStoryIndex == 0 && currentStoryIndex != 0 && currentStoryGlobalIndex < stories.count - 1 { // переключаемся на следующую глобальную историю
                changeStoriesStatus(index: currentStoryGlobalIndex)
                currentStoryGlobalIndex += 1
                progress = 0
            } else if nextStoryIndex == 0 && currentStoryIndex != 0 && currentStoryGlobalIndex == stories.count - 1 { // последняя закрываем
                service.changeStatusForViewedStories(story: currentStoryGlobalIndex)
                closeStories()
            } else {
                progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount) // следующее изображение в истории
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.startTimer()
        }
    }
    
    func prevStory() {
        stopTimer()
        
        let storiesCount = stories[currentStoryGlobalIndex].count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let prevStoryIndex = max(currentStoryIndex - 1, 0)
        
        withAnimation(.easeInOut(duration: 0.3)) {
            progress = CGFloat(prevStoryIndex) / CGFloat(storiesCount)
            
            if currentStoryIndex <= 0 && currentStoryGlobalIndex > 0 { // если есть куда переключаться во внутреннем массиве - идем
                currentStoryGlobalIndex -= 1
                let newStoriesCount = stories[currentStoryGlobalIndex].count
                progress = CGFloat(newStoriesCount - 1) / CGFloat(newStoriesCount)
            } else if currentStoryIndex == 0 && currentStoryGlobalIndex == 0 { // еси нету спрашиваем у сервиса
                service.needUpdateActualStory(globalNumber: currentStoryGlobalIndex)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.startTimer()
        }
    }
}

// Timer
extension StoriesLentViewModel {
    
    func startTimer() {
        guard !isTimerActive,
              isReady,
              !stories.isEmpty,
              currentStoryGlobalIndex < stories.count,
              let config = configuration else {
            return
        }
        
        isTimerActive = true
        timer = Timer.scheduledTimer(withTimeInterval: config.timerTickInternal, repeats: true) { [weak self] _ in
            self?.timerTick()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerActive = false
    }
    
    private func timerTick() {
        guard let config = configuration else { return }
        
        let newProgress = progress + config.progressPerTick
        
        if newProgress >= 1.0 {
            progress = 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.completeCurrentStory()
            }
        } else {
            withAnimation(.linear(duration: config.timerTickInternal)) {
                progress = newProgress
            }
        }
    }
    
    private func completeCurrentStory() {
        stopTimer()
        
        changeStoriesStatus(index: currentStoryGlobalIndex) // помечаем как просмотренную
        
        if currentStoryGlobalIndex < stories.count - 1 {
            // Переходим к следующей истории
            withAnimation(.easeInOut(duration: 0.3)) {
                currentStoryGlobalIndex += 1
                progress = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.startTimer()
            }
        } else {
            // Последняя история - закрываем
            closeStories()
        }
    }
}
