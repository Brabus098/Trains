//  StoriesModelMock.swift

extension StoriesModel {
    static let mainImageViewArray: [MainStoriesModel] = [MainStoriesModel(image: "1", borderStatus: true),
                                                         MainStoriesModel(image: "2", borderStatus: true),
                                                         MainStoriesModel(image: "3", borderStatus: true),
                                                         MainStoriesModel(image: "4", borderStatus: true),
                                                         MainStoriesModel(image: "5", borderStatus: true) ]
    
    static let mocksLentDictionary: [Int : [String]] = [1 : ["worker1", "worker2"],
                                                        2 : ["girlInTrain1", "girlInTrain2"],
                                                        3 : ["mainStopTrain", "peopleAtTrain"],
                                                        4 : ["trainPlace1", "trainPlace2"],
                                                        5: ["movingTrain1", "movingTrain2"]]
}
