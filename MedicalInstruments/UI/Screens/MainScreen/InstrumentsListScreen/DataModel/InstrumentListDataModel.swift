//
//  InstrumentListDataModel.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 24.03.2022.
//

import Foundation

enum InstrumentListViewEvent {
    case setLike(Int)
    case removeLike(Int)
}

enum Titles {
    case title
    
    func getTitle(type: String) -> (String, String) {
    switch type {
    case "separation":
        let title = "Общая хирургия"
        let subTitle = "Раздел: " + "Разъединяющие"
        return (title, subTitle)
    case "connection":
        let title = "Общая хирургия"
        let subTitle = "Раздел: " + "Соединяющие"
        return (title, subTitle)
    case "spreading":
        let title = "Общая хирургия"
        let subTitle = "Раздел: " + "Оттесняющие"
        return (title, subTitle)
    case "hold":
        let title = "Общая хирургия"
        let subTitle = "Раздел: " + "Удерживающие"
        return (title, subTitle)
    case "stabbing":
        let title = "Общая хирургия"
        let subTitle = "Раздел: " + "Колющие"
        return (title, subTitle)
    case "stomatology":
        let  title = Category.stomatology.getTitle()
        return (title, "")
    case "gynecology":
        let title = Category.gynecology.getTitle()
        return (title, "")
    case "neuro":
        let title = Category.neuro.getTitle()
        return (title, "")
    case "lor":
        let title = Category.lor.getTitle()
        return (title, "")
    case "urology":
        let title = Category.urology.getTitle()
        return (title, "")
    case "ophthalmology":
        let title = Category.ophthalmology.getTitle()
        return (title, "")
    case "anesthesiology":
        let title = Category.anesthesiology.getTitle()
        return (title, "")
    default:
        let title = "Инструменты"
        return (title, "")
    }
    }
}
