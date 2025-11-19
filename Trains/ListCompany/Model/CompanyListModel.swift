//  CompanyListModel.swift

import Foundation

struct Company: Identifiable {
    var id = UUID()
    var companyName: String
    var image: String // image(systemImage: "top")
    var timeToStart: String // 22:30
    var timeToOver: String // 11:49
    var allTimePath: String // 8 часов
    var date: String // 14 января
    var needSwapStation: Bool // true
    var swapStation: String? // If needSwapStation == true swapStation = Кострома
    var timeOfDay: TimeOfDay
}

struct TimeOfDirection {
    var status: Bool
    var time: TimeOfDay
}

enum TimeOfDay {
    case morning, day, afternoon, night, none
}

enum NeedSwap {
    case yes
    case no
}

struct CompanyListModel {
    let mockCompanies: [Company] = [
        Company(
            companyName: "РЖД Экспресс",
            image: "rgd",
            timeToStart: "06:15",
            timeToOver: "14:30",
            allTimePath: "8 ч",
            date: "16 ноября",
            needSwapStation: false,
            swapStation: nil,
            timeOfDay: .morning
        ),
        Company(
            companyName: "МежгородАвто",
            image: "TransCargo",
            timeToStart: "08:45",
            timeToOver: "12:20",
            allTimePath: "4 ч",
            date: "17 ноября",
            needSwapStation: true,
            swapStation: "Ярославле",
            timeOfDay: .morning
        ),
        Company(
            companyName: "АэроФлот Региональный",
            image: "Aeroflot",
            timeToStart: "11:20",
            timeToOver: "13:50",
            allTimePath: "3 ч",
            date: "18 ноября",
            needSwapStation: false,
            swapStation: nil,
            timeOfDay: .morning
        ),
        Company(
            companyName: "ТрансКарго",
            image: "TransCargo",
            timeToStart: "09:00",
            timeToOver: "21:30",
            allTimePath: "13 ч",
            date: "19 ноября",
            needSwapStation: true,
            swapStation: "Владимире",
            timeOfDay: .morning
        ),
        Company(
            companyName: "Волна-Тур",
            image: "Aeroflot",
            timeToStart: "15:40",
            timeToOver: "19:10",
            allTimePath: "4 ч",
            date: "20 ноября",
            needSwapStation: false,
            swapStation: nil,
            timeOfDay: .day
        ),
        Company(
            companyName: "Скоростной Транзит",
            image: "Aeroflot",
            timeToStart: "07:30",
            timeToOver: "10:15",
            allTimePath: "3 ч",
            date: "21 ноября",
            needSwapStation: true,
            swapStation: "Твери",
            timeOfDay: .morning
        ),
        Company(
            companyName: "Грузовой Альянс",
            image: "rgd",
            timeToStart: "22:00",
            timeToOver: "06:45",
            allTimePath: "9 ч",
            date: "22 ноября",
            needSwapStation: false,
            swapStation: nil,
            timeOfDay: .night
        )
    ]
    
    func returnCompany(from: SelectedDirection, to: SelectedDirection) -> [Company]? {
        guard mockCompanies.isEmpty == false else { return nil }
        return mockCompanies
    }
}
