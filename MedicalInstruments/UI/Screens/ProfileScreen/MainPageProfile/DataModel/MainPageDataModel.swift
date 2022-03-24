//
//  MainPageDataModel.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import Foundation

enum MainPageViewEvent {
    case exitClicked
    case yesButtonClicked
    case noButtonClicked
    case switchToTestClicked
    case tryAgainClicked
}


enum CategoryTypes {
    
    case surgery
    case stomatology
    case gynecology
    case neuro
    case lor
    case urology
    case ophthalmology
    case anesthesiology
    
    func getTitle() -> String {
        switch self {
        case .surgery:
            return "Общая хирургия"
        case .stomatology:
            return "Стоматология"
        case .gynecology:
            return "Гинекология"
        case .neuro:
            return "Нейрохирургия"
        case .lor:
            return "Отоларингология"
        case .urology:
            return "Урология"
        case .ophthalmology:
            return "Офтальмология"
        case .anesthesiology:
            return "Анестезиология"
        }
    }
}
