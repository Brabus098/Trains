//  StoriesModel.swift

import SwiftUI

struct StoriesModel {
    
    // MARK: - Properties

    let mainImageViewArray = StoriesModel.mainImageViewArray
    let mocksLentDictionary = StoriesModel.mocksLentDictionary
    
    // MARK: - Methods

    func returnImageLent() -> StoriesLentModel {
        StoriesLentModel(imageArray: mocksLentDictionary)
    }
    
    func convertToStory(number: Int) -> [[Story]] {
        var storyArray = [[Story]]()
        var stringMassive = [[String]]()
        
        let sortedMocksDictionary = mocksLentDictionary.sorted(by: { $1.key > $0.key })
        
        for i in sortedMocksDictionary {
            if i.key >= number {
                stringMassive.append(i.value)
            }
        }
        
        for j in stringMassive {
            storyArray.append(j.map { Story(image: $0)})
        }
        
        return storyArray
    }
}
