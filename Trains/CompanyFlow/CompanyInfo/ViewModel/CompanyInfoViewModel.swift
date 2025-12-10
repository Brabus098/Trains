//  CompanyInfoViewModel.swift

import Observation
import Combine
import Foundation

@Observable final class CompanyInfoViewModel {
    
    var infoCompany: CompanyInfoModel?
    
    private var service: CompanyService
    private var cancelLables = Set<AnyCancellable>()
    
    init(service: CompanyService) {
        self.service = service
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        service.companyDetailPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                if let detail = newState?.detailInfo {
                    self?.infoCompany = CompanyInfoModel(bigLogoName: detail.bigLogoName, fullCompanyName: detail.fullCompanyName, email: detail.email, phone: detail.phone)
                }
            }
            .store(in: &cancelLables)
    }
}
