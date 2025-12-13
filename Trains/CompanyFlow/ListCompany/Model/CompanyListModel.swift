//  CompanyListModel.swift

import Foundation

struct CompanyListModel {
    
    let mockCompanies: [CompanyModel] = CompanyModel.mockCompanies
    
    func returnCompany(from: DirectionModel, to: DirectionModel) -> [CompanyModel]? {
        guard mockCompanies.isEmpty == false else { return nil }
        return mockCompanies
    }
}
