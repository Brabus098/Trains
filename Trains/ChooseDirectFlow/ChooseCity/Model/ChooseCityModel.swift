//  ChooseCityModel.swift

import Foundation

struct ChooseCityModel {
    
    private let cityList = ChoosePlaceModel.mockCities
    
    func getCityList() -> [ChoosePlaceModel] {
        cityList.map { $0 }
    }
}
