//  ChooseCityViewModel.swift

import Foundation
import Observation

@Observable class ChooseCityViewModel {
    
    var listIsEmpty: Bool = false
    var cityList: [String]?
    
    private let model: ChooseCityModel
    private let directionService: DirectionsService
    
    init(directionService: DirectionsService) {
        self.model = ChooseCityModel()
        self.directionService = directionService
    }

    func needCityArray() {
        cityList = model.getCityList()
        if let list = cityList, !list.isEmpty {
            listIsEmpty = false
        }
    }
    
    func filterCity(by word: String) {
        guard let cityList else { return }

        if word.isEmpty {
            needCityArray()
            return
        }
        
        let newList = cityList.filter {
            $0.localizedCaseInsensitiveContains(word)
        }
        
        if newList.isEmpty {
            listIsEmpty = true
        } else {
            self.cityList = newList
        }
    }
    
    func setSelectedCity(_ place: String) {
        directionService.selectedCity = place
    }
}

