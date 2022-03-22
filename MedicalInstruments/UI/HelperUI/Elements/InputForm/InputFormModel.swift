//
//  InputFormModel.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import Foundation

protocol SuggestionItemProtocol {
    var title: String { get }
    var subTitle: String { get }
}

enum InputFormType {
    case phoneNumber
    case email
    case name
    case text
    case postalCode
    case password
}

enum InputFormState {
    case disable
    case errorFilled
    case errorNotFilled
    case normal
}
