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
}

private func getPath(for method: String) -> String {
    return "/public/api/\(method)"
}

extension ApiClient: CatalogApiClientProtocol {
    func getInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, Error> {
        let request = requestBuilder.postBuild(
            path: getPath(for: "getInstrumentsByType"),
            urlParametrs: [
                "type": params.type
            ])
        return performRequest(request)
    }
}
