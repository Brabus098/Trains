//  CompanyListViewModel.swift

import Foundation
import Observation
import Combine

@Observable final class CompanyListViewModel {
    
    private let model: CompanyListModel
    private let service: CompanyService
    private let directionService: DirectionsService
    private var cancelLables = Set<AnyCancellable>()
    
    var to: DirectionModel?
    var from: DirectionModel?
    
    var filterCompanies: [CompanyModel]?
    var visibleButtonStatus = false
    
    init(service: CompanyService, directionService: DirectionsService) {
        self.model = CompanyListModel()
        self.service = service
        self.directionService = directionService
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        service.buttonStatusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.visibleButtonStatus = newState
            }
            .store(in: &cancelLables)
        service.filterCompaniesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] filterCompanies in
                self?.filterCompanies = filterCompanies
            }
            .store(in: &cancelLables)
        
        directionService.directionToPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] to in
                self?.to = to
                Task {
                    await self?.getCompany(and: true)
                }
            }
            .store(in: &cancelLables)
        directionService.directionFromPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] from in
                self?.from = from
                Task {
                    await self?.getCompany(and: true)
                } // Обнуляем состояние фильтров и обновляем состояние списка компаний
            }
            .store(in: &cancelLables)
    }
    
    func getCompany(and resetValue: Bool) async {
        
        if let to = to, let from = from, let newCompanies = model.returnCompany(from: from, to: to) {
            service.set(basicCompanies: newCompanies)
            service.set(filterCompany: newCompanies)
        }
        
        if resetValue {
            service.reset()
        }
    }
    
    func setSelectCompany(detail: CompanyModel) {
        service.set(selectedCompanies: detail)
    }
}






