//
//  CatalogClient.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import Foundation
import Combine

protocol CatalogApiClientProtocol {
    func getInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, Error>
    func getCategories() -> AnyPublisher<GetCategoriesResponse, Error>
    func getSubCategories() -> AnyPublisher<GetSubCategoriesResponse, Error>
    func getSurgeryInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, Error>
    func login(with params: LoginRequestParams) -> AnyPublisher<LoginResponse, Error>
    func getProfileData() -> AnyPublisher<GetProfileDataResponse, Error>
    func register(with params: RegisterRequestParams) -> AnyPublisher<RegisterResponse, Error>
    func getTypes() -> AnyPublisher<GetTypesResponse, Error>
    func getQuestionByTypeAndLevel(with params: getQuestionByTypeAndLevelRequestParams) -> AnyPublisher<GetQuestionByTypeAndLevelResponse, Error>
}

private func getPath(for method: String) -> String {
    return "/public/api/\(method)"
}

extension ApiClient: CatalogApiClientProtocol {
    
    func getCategories() -> AnyPublisher<GetCategoriesResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getCategories"),
            urlParametrs: [:])
        return performRequest(request)
    }
    
    func getInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getInstrumentsByType"),
            urlParametrs: [
                "type": params.type,
                "user_token": Keychain.shared.getUserToken() ?? ""
            ])
        return performRequest(request)
    }
    
    func getSurgeryInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getSurgeryInstrumentsByType"),
            urlParametrs: [
                "type": params.type,
                "user_token": Keychain.shared.getUserToken() ?? ""
            ])
        return performRequest(request)
    }
    
    func getSubCategories() -> AnyPublisher<GetSubCategoriesResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getSubCategories"),
            urlParametrs: [:])
        return performRequest(request)
    }
    
    func login(with params: LoginRequestParams) -> AnyPublisher<LoginResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "login"),
            urlParametrs: [
                "email": params.email,
                "password": params.password
            ])
        return performRequest(request)
    }
    
    func getProfileData() -> AnyPublisher<GetProfileDataResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getProfileData"),
            urlParametrs: [
                "user_token": Keychain.shared.getUserToken() ?? ""
            ])
        return performRequest(request)
    }
    
    func register(with params: RegisterRequestParams) -> AnyPublisher<RegisterResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "register"),
            urlParametrs: [
                "name": params.name,
                "email": params.email,
                "password": params.password,
                "password_confirmation": params.password_confirmation
            ])
        return performRequest(request)
    }
  
    func getTypes() -> AnyPublisher<GetTypesResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getTypes"),
            urlParametrs: [:])
        return performRequest(request)
    }
    
    func getQuestionByTypeAndLevel(with params: getQuestionByTypeAndLevelRequestParams) -> AnyPublisher<GetQuestionByTypeAndLevelResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getQuestionByTypeAndLevel"),
            urlParametrs: [
                "type": params.type,
                "level": params.level
            ])
        return performRequest(request)
    }
   
    
}
