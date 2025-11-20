//  ChoosePlaceModel.swift

struct ChoosePlaceModel: Hashable, Identifiable {
    var id = UUID()
    var city: String
    var trainStations: [String]
}
