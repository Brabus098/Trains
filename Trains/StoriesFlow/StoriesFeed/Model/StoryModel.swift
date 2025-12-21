//  Story.swift

struct Story {
    let image: String
    
    var title: String {
        get  {
            Story.randomTitles.randomElement() ??
            "Text Text Text Text Text Text Text Text Text Text"
        }
    }
    
    var description: String {
        get {
            Story.randomDescriptions.randomElement() ??
            "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        }
    }
}
