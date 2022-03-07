//
//  PrettyAlertDataModel.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

enum PrettyAlertViewEvent {
    case buttonClicked(Int)
}

enum PrettyAlertButtonType {
    case standart
    case action
}

struct PrettyAlertInitialization {
    
    let title: String
    let message: String
    let buttons: [ButtonInfo]
}

struct ButtonInfo {
    var title: String
    var type: PrettyAlertButtonType
    var action: VoidClosure?
}
