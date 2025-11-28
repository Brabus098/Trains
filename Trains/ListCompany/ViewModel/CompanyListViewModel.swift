//  CompanyListViewModel.swift

import Foundation
import Observation

@Observable final class CompanyListViewModel {
    
    private let model: CompanyListModel
    var companies: [CompanyModel]?
    var filterCompanies: [CompanyModel]?
    var visibleButtonStatus = false
    var selectedCompanyDetail: CompanyModel?
    
    var morningButtonState: TimeOfDirectionModel = TimeOfDirectionModel(status: false,
                                                                        time: .morning)
    var dayButtonState: TimeOfDirectionModel = TimeOfDirectionModel(status: false,
                                                                    time: .day)
    var afternoonButtonState: TimeOfDirectionModel = TimeOfDirectionModel(status: false,
                                                                          time: .afternoon)
    var nightButtonState: TimeOfDirectionModel = TimeOfDirectionModel(status: false,
                                                                      time: .night)
    
    var yesRadioButtonState = false
    var noRadioButtonState = false
    
    init() {
        self.model = CompanyListModel()
    }
    
    func getCompany(from: DirectionModel, to: DirectionModel) {
        companies = model.returnCompany(from: from, to: to)
        filterCompanies = companies
    }
    
    func checkAllStatesAdded() {
        let firstGroup = [morningButtonState.status, dayButtonState.status, afternoonButtonState.status, nightButtonState.status]
        let secondGroup = [yesRadioButtonState, noRadioButtonState]
        
        if firstGroup.contains(true) && secondGroup.contains(true) {
            visibleButtonStatus = true
        } else {
            visibleButtonStatus = false
        }
    }
    
    func filterForCompanies() {
        let firstGroup = [morningButtonState, dayButtonState, afternoonButtonState, nightButtonState].filter { $0.status == true }
        
        let secondGroup: Bool = yesRadioButtonState ? true : false
        
        if let companyArray = companies {
            filterCompanies = companyArray.filter { value in
                return value.needSwapStation == secondGroup &&  firstGroup.contains { $0.time == value.timeOfDay }
            }
        }
    }
}

