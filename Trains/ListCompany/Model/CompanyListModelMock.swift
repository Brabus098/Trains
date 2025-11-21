//  CompanyListModelMock.swift

import Foundation

extension CompanyModel {
    static let mockCompanies: [CompanyModel] =  [CompanyModel(
        companyName: "РЖД Экспресс",
        image: "rgd",
        timeToStart: "06:15",
        timeToOver: "14:30",
        allTimePath: "8 ч",
        date: "16 ноября",
        needSwapStation: false,
        swapStation: nil,
        timeOfDay: .morning,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "ОАО «РЖД Экспресс»",
            email: "info@rzd-express.ru",
            phone: "+7 (800) 775-00-00"
        )
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
        timeOfDay: .morning,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "ООО «МежгородАвто»",
            email: "zakaz@mezhgorodauto.ru",
            phone: "+7 (4852) 22-33-44"
        )
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
        timeOfDay: .morning,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "АО «АэроФлот Региональный»",
            email: "contact@aeroflot-regional.ru",
            phone: "+7 (495) 223-55-55"
        )
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
        timeOfDay: .morning,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "ПАО «ТрансКарго»",
            email: "office@transcargo.ru",
            phone: "+7 (4922) 55-66-77"
        )
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
        timeOfDay: .day,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "Туристическая компания «Волна‑Тур»",
            email: "tour@volna-tur.ru",
            phone: "+7 (812) 333-44-55"
        )
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
        timeOfDay: .morning,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "ООО «Скоростной Транзит»",
            email: "transit@skorost-transit.ru",
            phone: "+7 (4822) 77-88-99"
        )
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
        timeOfDay: .night,
        detailInfo: CompanyInfoModel(
            bigLogo: "bigRgd",
            fullCompanyName: "ЗАО «Грузовой Альянс»",
            email: "cargo@gruzovoy-alyans.ru",
            phone: "+7 (800) 123-45-67"
        )
    )
]
}
