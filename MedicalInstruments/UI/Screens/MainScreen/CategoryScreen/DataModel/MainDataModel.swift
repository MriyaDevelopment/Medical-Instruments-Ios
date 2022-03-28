//
//  MainDataModel.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 08.03.2022.
//

import UIKit
import SwiftUI

enum MainViewEvent {
    case cellClicked(String)
    case firstCellClicked
    case switchToProfile
}

struct MainStruct {
    var id: Int
    var backgroundImage: UIImage
    var iconImage: UIImage
    var type: String
    var titleText: String
    var subtitleText: String
}

enum Category: String {
    
    case surgery = "Общая хирургия"
    case stomatology = "Стоматология"
    case gynecology = "Гинекология"
    case neuro = "Нейрохирургия"
    case lor = "Отоларингология"
    case urology = "Урология"
    case ophthalmology = "Офтальмология"
    case anesthesiology = "Анестезиология"
    
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
    
    func getImage() -> UIImage {
        switch self {
        case .surgery:
            return AppIcons.getIcon(.i_surgery_back)
        case .stomatology:
            return AppIcons.getIcon(.i_dentistry)
        case .gynecology:
            return AppIcons.getIcon(.i_AiG)
        case .neuro:
            return AppIcons.getIcon(.i_neurosurgery)
        case .lor:
            return AppIcons.getIcon(.i_ophthalmology)
        case .urology:
            return AppIcons.getIcon(.i_otorhinolaryngology)
        case .ophthalmology:
            return AppIcons.getIcon(.i_syringe_back)
        case .anesthesiology:
            return AppIcons.getIcon(.i_urology_back)
        }
    }
    
    func getIcons() -> UIImage {
        switch self {
        case .surgery:
            return AppIcons.getIcon(.i_icon_surgery)
        case .stomatology:
            return AppIcons.getIcon(.i_icon_dentisty)
        case .gynecology:
            return AppIcons.getIcon(.i_icon_aig)
        case .neuro:
            return AppIcons.getIcon(.i_icon_neuro)
        case .lor:
            return AppIcons.getIcon(.i_icon_oftalm)
        case .urology:
            return AppIcons.getIcon(.i_icon_otorin)
        case .ophthalmology:
            return AppIcons.getIcon(.i_icon_syringe)
        case .anesthesiology:
            return AppIcons.getIcon(.i_icon_urology)
        }
    }
    
}

enum CategorySurgery {
    case separating
    case connecting
    case pushing
    case holding
    case stabbing
    
    func getIcons() -> UIImage {
        switch self {
        case .separating:
            return AppIcons.getIcon(.i_surgery_separating)
        case .connecting:
            return AppIcons.getIcon(.i_surgery_connecting)
        case .pushing:
            return AppIcons.getIcon(.i_surgery_pushing)
        case .holding:
            return AppIcons.getIcon(.i_surgery_holding)
        case .stabbing:
            return AppIcons.getIcon(.i_sugery_stabbing)
        }
    }
}
