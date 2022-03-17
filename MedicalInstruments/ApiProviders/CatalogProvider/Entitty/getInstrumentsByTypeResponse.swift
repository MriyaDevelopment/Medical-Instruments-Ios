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
//    let is_liked: Bool?
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
