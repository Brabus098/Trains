//  CompanyListModel.swift

struct CompanyListModel {
    let mockCompanies: [CompanyModel] = [
        CompanyModel(
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
        CompanyModel(
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
        CompanyModel(
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
        CompanyModel(
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
        CompanyModel(
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
        CompanyModel(
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
        CompanyModel(
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
    
    func returnCompany(from: DirectionModel, to: DirectionModel) -> [CompanyModel]? {
        guard mockCompanies.isEmpty == false else { return nil }
        return mockCompanies
    }
}
