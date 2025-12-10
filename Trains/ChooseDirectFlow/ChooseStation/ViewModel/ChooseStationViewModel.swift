//  ChooseStationViewModel.swift

import Observation
import Foundation

@Observable final class ChooseStationViewModel {
    
    var listIsEmpty: Bool = false
    var stationList: [String]?
    
    private let model: ChooseStationModel
    private let directionService: DirectionsService
    
    init(directionService: DirectionsService) {
        self.model = ChooseStationModel()
        self.directionService = directionService
    }
    
    func filterStation(by word: String) {
        guard let stationList else { return }
        
        if word.isEmpty {
            Task{
                await needStationForCity()
            }
            return
        }
        
        let newList = stationList.filter { $0.localizedCaseInsensitiveContains(word) }
        
        if newList.isEmpty {
            listIsEmpty = true
        } else {
            self.stationList = newList
        }
    }
    
    func needStationForCity() async {
        guard let selectedCity = directionService.selectedCity else { return }
        stationList = model.getStation(for: selectedCity)
        if let stationList, !stationList.isEmpty {
            listIsEmpty = false
        }
    }
    
    func tryContainsDestination(){
        directionService.containsDestinationIfCan()
    }
    
    func tryActiveIfAdds() {
        directionService.activeIfAllAdds()
    }
    
    func setStation(with name: String) {
        directionService.selectedStation = name
    }
}
