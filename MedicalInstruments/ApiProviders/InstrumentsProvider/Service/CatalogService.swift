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
    func getSurgeryInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, ApiError>
    func getCategories() -> AnyPublisher<GetCategoriesResponse, ApiError>
    func getSubCategories() -> AnyPublisher<GetSubCategoriesResponse, ApiError>
    func login(with params: LoginRequestParams) -> AnyPublisher<LoginResponse, ApiError>
    func getProfileData() -> AnyPublisher<GetProfileDataResponse, ApiError>
    func register(with params: RegisterRequestParams) -> AnyPublisher<RegisterResponse, ApiError>
    func getTypes() -> AnyPublisher<GetTypesResponse, ApiError>
    func getQuestionByTypeAndLevel(with params: getQuestionByTypeAndLevelRequestParams) -> AnyPublisher<GetQuestionByTypeAndLevelResponse, ApiError>
    func setResult(with params: SetResultRequestParams) -> AnyPublisher<SetResultResponse, ApiError>
    func getResult() -> AnyPublisher<GetResultResponse, ApiError>
    func setLike(with params: SetLikeRequestParams) -> AnyPublisher<SetRemoveLikeResponse, ApiError>
    func removeLike(with params: RemoveLikeRequestParams) -> AnyPublisher<SetRemoveLikeResponse, ApiError>
    func getFavourites() -> AnyPublisher<GetFavouritesResponse, ApiError>
    func getLastTest() -> AnyPublisher<GetLastTestResponse, ApiError>
    func getLevels() -> AnyPublisher<GetLevelsResponse, ApiError>
}

class CatalogService: CatalogServiceProtocol {
    
    private let apiClient: CatalogApiClientProtocol
    private var request: AnyCancellable?
    private var userDataRequest: AnyCancellable?
    private var resultRequest: AnyCancellable?
    private var favRequest: AnyCancellable?
    private var levelsRequest: AnyCancellable?
    
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
    
    func getSurgeryInstrumentsByType(with params: getInstrumentsByTypeRequestParams) -> AnyPublisher<getInstrumentsByTypeResponse, ApiError> {
        request?.cancel()
        
        return apiClient.getSurgeryInstrumentsByType(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getCategories() -> AnyPublisher<GetCategoriesResponse, ApiError> {
        request?.cancel()
        
        return apiClient.getCategories()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getSubCategories() -> AnyPublisher<GetSubCategoriesResponse, ApiError> {
        request?.cancel()
        
        return apiClient.getSubCategories()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func login(with params: LoginRequestParams) -> AnyPublisher<LoginResponse, ApiError> {
        request?.cancel()
        
        return apiClient.login(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getProfileData() -> AnyPublisher<GetProfileDataResponse, ApiError> {
        userDataRequest?.cancel()
        
        return apiClient.getProfileData()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func register(with params: RegisterRequestParams) -> AnyPublisher<RegisterResponse, ApiError> {
        request?.cancel()
        
        return apiClient.register(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getTypes() -> AnyPublisher<GetTypesResponse, ApiError> {
        request?.cancel()
        
        return apiClient.getTypes()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getQuestionByTypeAndLevel(with params: getQuestionByTypeAndLevelRequestParams) -> AnyPublisher<GetQuestionByTypeAndLevelResponse, ApiError> {
        request?.cancel()
        
        return apiClient.getQuestionByTypeAndLevel(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func setResult(with params: SetResultRequestParams) -> AnyPublisher<SetResultResponse, ApiError> {
        request?.cancel()
        
        return apiClient.setResult(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getResult() -> AnyPublisher<GetResultResponse, ApiError> {
        resultRequest?.cancel()
        
        return apiClient.getResult()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func setLike(with params: SetLikeRequestParams) -> AnyPublisher<SetRemoveLikeResponse, ApiError> {
        request?.cancel()
        
        return apiClient.setLike(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func removeLike(with params: RemoveLikeRequestParams) -> AnyPublisher<SetRemoveLikeResponse, ApiError> {
        request?.cancel()
        
        return apiClient.removeLike(with: params)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getFavourites() -> AnyPublisher<GetFavouritesResponse, ApiError> {
        favRequest?.cancel()
        
        return apiClient.getFavourites()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getLastTest() -> AnyPublisher<GetLastTestResponse, ApiError> {
        favRequest?.cancel()
        
        return apiClient.getLastTest()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func getLevels() -> AnyPublisher<GetLevelsResponse, ApiError> {
        levelsRequest?.cancel()
        
        return apiClient.getLevels()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
}
