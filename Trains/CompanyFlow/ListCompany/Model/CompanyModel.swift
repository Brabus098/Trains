//  CompanyModel.swift

import Foundation

struct CompanyModel: Identifiable, Decodable, Sendable {
    var id = UUID()
    let companyName: String
    let image: String
    let timeToStart: String
    let timeToOver: String
    let allTimePath: String
    let date: String
    let needSwapStation: Bool
    let swapStation: String?
    let timeOfDay: TimeOfDayType
    let detailInfo: CompanyInfoModel
}
