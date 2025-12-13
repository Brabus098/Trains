//  ChoosePlaceModel.swift

import Foundation

struct ChoosePlaceModel: Hashable, Identifiable, Sendable, Decodable {
    var id = UUID()
    let cityName: String
    let lat: String
    let lng: String
    let distance: String
}
