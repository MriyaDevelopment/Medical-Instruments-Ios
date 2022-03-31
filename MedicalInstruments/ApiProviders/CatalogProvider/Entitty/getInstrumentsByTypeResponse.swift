//
//  getInstrumentsByTypeResponse.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import Foundation

struct getInstrumentsByTypeResponse: Codable {
    let error: String?
    let result: String?
    let instruments: [Instruments]?
}

struct Instruments: Codable {
    let id: Int?
    let title: String?
    let type: String?
    let image: String?
    let full_text: String?
    let is_liked: Bool?
    let is_surgery: Bool?
}

struct GetCategoriesResponse: Codable {
    let error: String?
    let result: String?
    let category: [MainCategory]?
}

struct MainCategory: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let number_of_questions: Int?
}

struct GetSubCategoriesResponse: Codable {
    let error: String?
    let result: String?
    let subcategory: [MainCategory]?
}

struct LoginResponse: Codable {
    let error: String?
    let result: String?
    let user: User?
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let api_token: String
    let is_subscribed: Bool
}

struct GetProfileDataResponse: Codable {
    let error: String?
    let result: String?
    let user: [User]?
}

struct RegisterResponse: Codable {
    let error: String?
    let result: String?
    let email: [String]?
    let register: Register?
}
 
struct Register: Codable {
    let name: String?
    let email: String?
    let api_token: String?
    let id: Int?
}

struct GetTypesResponse: Codable {
    let error: String?
    let result: String?
    let types: [Types]?
}

struct Types: Codable {
    let name: String?
    let title: String?
    let id: Int?
}

struct GetQuestionByTypeAndLevelResponse: Codable {
    let result: String?
    let error: String?
    let questions: [Questions]?
}

struct Questions: Codable {
    let id: Int?
    let question: String?
    let type: String?
    let level: Int?
    let answer_one: String?
    let answer_two: String?
    let answer_three: String?
    let answer_four: String?
    let true_answer: String?
}

struct SetResultResponse: Codable {
    let error: String?
    let result: String?
    let data: ResultData?
}

struct ResultData: Codable {
    let level: String?
    let categories: String?
    let number_of_correct_answers: String?
    let number_of_questions: String?
    let questions: String?
}

struct GetResultResponse: Codable {
    let error: String?
    let result: String?
    let levels: [GetResultData]?
}

struct GetResultData: Codable {
    let level: Int?
    let categories: String?
    let number_of_correct_answers: Int?
    let number_of_questions: Int?
    let questions: String?
}

struct SetRemoveLikeResponse: Codable {
    let result: String?
    let error: String?
}

struct GetFavouritesResponse: Codable {
    let result: String?
    let error: String?
    let instruments: [Instruments]?
}

struct GetLastTestResponse: Codable {
    let result: String?
    let error: String?
    let questions: [Questions]?
}

struct GetLevelsResponse: Codable {
    let result: String?
    let error: String?
    let levels: [Levels]?
}

struct Levels: Codable {
    let id: Int?
    let name: String?
    let number_of_questions: Int?
}
