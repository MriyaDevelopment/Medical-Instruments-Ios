//
//  CatalogProviderRequestParam.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import Foundation

struct getInstrumentsByTypeRequestParams {
    let type: String

    init(type: String) {
        self.type = type
    }
}

struct LoginRequestParams {
    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct RegisterRequestParams {
    
    let name: String
    let email: String
    let password: String
    let password_confirmation: String

    init(name: String ,email: String, password: String, password_confirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.password_confirmation = password_confirmation
    }
}

struct getQuestionByTypeAndLevelRequestParams {
    let type: String
    let level: String

    init(type: String, level: String) {
        self.type = type
        self.level = level
    }
}

struct SetResultRequestParams {
    
    let level: String
    let categories: String
    let number_of_correct_answers: String
    let number_of_questions: String
    let questions: String

    init(level: String, categories: String, number_of_correct_answers: String, number_of_questions: String, questions: String) {
        self.level = level
        self.categories = categories
        self.number_of_correct_answers = number_of_correct_answers
        self.number_of_questions = number_of_questions
        self.questions = questions
    }
}
