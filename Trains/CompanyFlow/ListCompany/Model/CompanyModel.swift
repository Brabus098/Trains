//  CompanyModel.swift

import Foundation

struct CompanyModel: Identifiable {
    let id = UUID()
    let companyName: String
    let image: String // image(systemImage: "top")
    let timeToStart: String // 22:30
    let timeToOver: String // 11:49
    let allTimePath: String // 8 часов
    let date: String // 14 января
    let needSwapStation: Bool // true
    let swapStation: String? // If needSwapStation == true swapStation = Кострома
    let timeOfDay: TimeOfDayType
    let detailInfo: CompanyInfoModel
}
