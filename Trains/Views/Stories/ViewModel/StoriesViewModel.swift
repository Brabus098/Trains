//  StoriesViewModel.swift

import SwiftUI

@Observable final class StoriesViewModel {
    var mainImageViewArray: [MainStoriesModel]?
    var lentDictionary: StoriesLentModel?
    var isCloseStories: Bool = false
    private let model: StoriesModel
    
    var actualStory: [[Story]]?
    var actualNumber: Int?
    
    
    init() {
        self.model = StoriesModel()
    }
    
    func createMainImageLent() {
        if mainImageViewArray == nil {
            self.mainImageViewArray = model.mainImageViewArray
        }
    }
    
    func createDetailImageLent() {
        self.lentDictionary = model.returnImageLent()
    }
    
    func createStoryArray(number: String) {
        actualStory = model.convertToStory(number: Int(number) ?? 0)
        actualNumber = Int(number) ?? 0
    }
    
    func needClose() {
        isCloseStories = true
    }
    
    func needUpdateActualStory(globalNumber: Int) {
        guard  let num = actualNumber else { return }
        if num - 1 > 0 {
            createStoryArray(number: String(num-1) )
        } else {
            needClose()
        }
    }
    
    func changeStatusFor(story: Int) {
        mainImageViewArray = mainImageViewArray?.map { storyModel in
            
            storyModel.image == String(story + (actualNumber ?? 0))
            ? MainStoriesModel(image: storyModel.image, borderStatus: false)
            : storyModel
        }
    }
}
