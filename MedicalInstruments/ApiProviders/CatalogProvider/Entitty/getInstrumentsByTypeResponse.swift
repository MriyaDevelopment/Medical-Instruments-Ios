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

