//  SettingModel.swift

struct CompanyInfoModel: Decodable, Sendable {
    let bigLogoName: String
    let fullCompanyName: String
    let email: String
    let phone: String
    let code: Int
}
