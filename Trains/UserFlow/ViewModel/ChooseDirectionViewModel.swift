//  ChooseDirectionViewModel.swift

import Observation
import Foundation
import Combine

@Observable class ChooseDirectionViewModel {
    
    var finalDirectionTo: String?
    var finalDirectionFrom: String?
    var allDirectionAdds: Bool?
    
    private var cancelLables = Set<AnyCancellable>()
    
    private let directionService: DirectionsService
    
    init(directionService: DirectionsService) {
        self.directionService = directionService
        addSubscribing()
    }
    
    func addSubscribing(){
        directionService.finalDirectionToPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] directionTo in
                self?.finalDirectionTo = directionTo
            }
            .store(in: &cancelLables)
        directionService.finalDirectionFromPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] directionFrom in
                self?.finalDirectionFrom = directionFrom
            }
            .store(in: &cancelLables)
        directionService.allDirectionAddsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newStatus in
                self?.allDirectionAdds = newStatus
            }
            .store(in: &cancelLables)
    }
    
    func needSwapDirection(){
        directionService.swapDirections()
    }
    
    func set(direction: DirectionType){
        directionService.directionType = direction
    }
}
