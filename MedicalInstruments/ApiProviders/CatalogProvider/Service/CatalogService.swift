//
//  CatalogService.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import Foundation
import Combine

protocol CatalogServiceProtocol {
    func getInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, ApiError>
}

class CatalogService: CatalogServiceProtocol {
    
    private let apiClient: CatalogApiClientProtocol
    private var request: AnyCancellable?
    
    init(apiClient: CatalogApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, ApiError> {

        request?.cancel()
        
        return apiClient.getInstrumentsByType(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
}
