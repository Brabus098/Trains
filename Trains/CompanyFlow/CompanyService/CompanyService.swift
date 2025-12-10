//  CompanyService.swift

import Observation
import Combine

@Observable final class CompanyService {
    
    private let buttonStatusSubject = CurrentValueSubject<Bool, Never>(false)
    private let cleanFilterButtonStateSubject = CurrentValueSubject<Bool, Never>(false)
    private let filteredCompaniesSubject = CurrentValueSubject<[CompanyModel]?, Never>(nil)
    private let companyDetailSubject = CurrentValueSubject<CompanyModel?, Never>(nil)
    
    var buttonStatusPublisher: AnyPublisher<Bool, Never> {
        buttonStatusSubject.eraseToAnyPublisher()
    }
    var cleanFilterButtonStatePublisher: AnyPublisher<Bool, Never> {
        cleanFilterButtonStateSubject.eraseToAnyPublisher()
    }
    var filterCompaniesPublisher: AnyPublisher <[CompanyModel]?, Never> {
        filteredCompaniesSubject.eraseToAnyPublisher()
    }
    var standardCompanies: [CompanyModel]?
    var companyDetailPublisher : AnyPublisher <CompanyModel?, Never> {
        companyDetailSubject.eraseToAnyPublisher()
    }
    
    func needChangeButton(status: Bool) {
        buttonStatusSubject.send(status)
    }
    
    func set(filterCompany: [CompanyModel]) {
        filteredCompaniesSubject.send(filterCompany)
    }
    
    func set(selectedCompanies: CompanyModel ) {
        companyDetailSubject.send(selectedCompanies)
    }
    
    func set(basicCompanies: [CompanyModel]) {
        self.standardCompanies = basicCompanies
    }
    
    func reset() {
        buttonStatusSubject.send(false)
        cleanFilterButtonStateSubject.send(false)
    }
}
