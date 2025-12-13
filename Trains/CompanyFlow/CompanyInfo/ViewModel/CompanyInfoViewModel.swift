//  CompanyInfoViewModel.swift

import Observation
import Combine
import Foundation

@MainActor @Observable final class CompanyInfoViewModel {
    
    var infoCompany: CompanyInfoModel?
    var companyDetail: CompanyModel?
  
    
    private var service: DirectionsService
    private var cancelLables = Set<AnyCancellable>()
    
    
    
    init(service: DirectionsService) {
        self.service = service
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        service.companyDetailPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
               
                    self?.infoCompany = newState
                
            }
            .store(in: &cancelLables)
    }
    
    func set(detail: CompanyModel) {
        self.companyDetail = detail
    }

}
