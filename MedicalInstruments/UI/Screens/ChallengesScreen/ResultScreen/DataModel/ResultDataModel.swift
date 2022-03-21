//
//  ResultDataModel.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 19.03.2022.
//

import Foundation

struct QuizResult {
    let time: String
    let level: String
    let categories: String
    let number_of_correct_answers: String
    let number_of_questions: String
    
    init(time: String, level: String, categories: String, number_of_correct_answers: String, number_of_questions: String) {
        self.time = time
        self.level = level
        self.categories = categories
        self.number_of_correct_answers = number_of_correct_answers
        self.number_of_questions = number_of_questions
    }
}
