//  StoryLentConfiguration.swift

import Foundation

struct StoryLentConfiguration:Sendable {
    let timerTickInternal: TimeInterval = 0.05  // Как часто тикает (техническое)
    private let secondsPerStory: TimeInterval = 10 // Сколько длится история (бизнес-правило)
    let progressPerTick: CGFloat // Сколько прогресса за тик (расчетное)
    
    init() {
        self.progressPerTick = timerTickInternal / secondsPerStory
    }
}
