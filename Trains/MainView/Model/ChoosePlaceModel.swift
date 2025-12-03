//  ChoosePlaceModel.swift
import Foundation

struct ChoosePlaceModel: Hashable, Identifiable {
    var id = UUID()
    var city: String
    var trainStations: [String]
}

