//  ChooseCityViewModel.swift

import Foundation
import Observation
import Combine

@MainActor @Observable class ChooseCityViewModel {
    
    var listIsEmpty: Bool = false
    var cityList: [ChoosePlaceModel]?
    
    private let model: ChooseCityModel
    private let directionService: DirectionsService
    
    init(directionService: DirectionsService) {
        self.model = ChooseCityModel()
        self.directionService = directionService
    }
    
    func needCityArray() async {
        cityList = model.getCityList()
        if let list = cityList, !list.isEmpty {
            listIsEmpty = false
        }
    }
    
    func filterCity(by word: String) {
        guard let cityList else { return }
        
        if word.isEmpty {
            Task{
                await needCityArray()
            }
            return
        }
        
        let newList = cityList.filter {
            $0.cityName.localizedCaseInsensitiveContains(word)
        }
        
        if newList.isEmpty {
            listIsEmpty = true
        } else {
            self.cityList = newList
        }
    }
    
    func setSelectedCity(_ place: ChoosePlaceModel) {
        directionService.selectedCity = place
    }
}


