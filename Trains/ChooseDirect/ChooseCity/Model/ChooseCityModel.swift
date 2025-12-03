//  ChooseCityModel.swift

import Foundation

struct ChooseCityModel {
    
    private let cityList = ChoosePlaceModel.mockCities
    
    func getCityList() -> [String] {
        cityList.map { $0.city }
    }
}
