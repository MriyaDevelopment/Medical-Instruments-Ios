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
                "type": params.type
            ])
        return performRequest(request)
    }
    
    func getSurgeryInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getSurgeryInstrumentsByType"),
            urlParametrs: [
                "type": params.type
            ])
        return performRequest(request)
    }
    
    func getSubCategories() -> AnyPublisher<GetSubCategoriesResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getSubCategories"),
            urlParametrs: [:])
        return performRequest(request)
    }
}
