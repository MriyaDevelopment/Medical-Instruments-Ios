//
//  CatalogProvider.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import Foundation
import Combine

protocol CatalogProviderProtocol {
    var events: PassthroughSubject<CatalogProviderEvent, Never> { get }
    func getInstrumentsByType(param: getInstrumentsByTypeRequestParams)
    func getSurgeryInstrumentsByType(param: getInstrumentsByTypeRequestParams)
    func getCategories()
    func getSubCategories()
    func login(with params: LoginRequestParams)
    func getProfileData()
    func register(with params: RegisterRequestParams)
    func getTypes()
    func getQuestionByTypeAndLevel(with params: getQuestionByTypeAndLevelRequestParams)
}

final class CatalogProviderImpl: CatalogProviderProtocol {
    let events = PassthroughSubject<CatalogProviderEvent, Never>()
    
    private let catalogService: CatalogServiceProtocol
    private var request: AnyCancellable?
    private var mainRequest: AnyCancellable?
    private var userData: AnyCancellable?

    init(catalogService: CatalogServiceProtocol) {
        self.catalogService = catalogService
    }
    
    func getInstrumentsByType(param: getInstrumentsByTypeRequestParams) {
        request?.cancel()
        
        request = catalogService.getInstrumentsByType(with: param)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.dataLoaded(result))
                default:
                    break
                }
            })
    }
    
    func getSurgeryInstrumentsByType(param: getInstrumentsByTypeRequestParams) {
        request?.cancel()
        
        request = catalogService.getSurgeryInstrumentsByType(with: param)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.dataLoaded(result))
                default:
                    break
                }
            })
    }
    
    func getCategories() {
        mainRequest?.cancel()
        
        request = catalogService.getCategories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.categoriesLoaded(result))
                default:
                    break
                }
            })
    }
    
    func getSubCategories() {
        request?.cancel()
        
        request = catalogService.getSubCategories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.subCategoriesLoaded(result))
                default:
                    break
                }
            })
    }
    
    func login(with params: LoginRequestParams) {
        request?.cancel()
        
        request = catalogService.login(with: params)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.loginSuccsess(result))
                default:
                    break
                }
            })
    }
   
    func getProfileData() {
        userData?.cancel()
        
        request = catalogService.getProfileData()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.profileDataLoaded(result))
                default:
                    break
                }
            })
    }
    
    func register(with params: RegisterRequestParams) {
        request?.cancel()
        
        request = catalogService.register(with: params)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.email?.first))
                case "success":
                    self.events.send(.registerSuccess(result))
                default:
                    break
                }
            })
    }
    
    func getTypes() {
        request?.cancel()
        
        request = catalogService.getTypes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.typesLoaded(result))
                default:
                    break
                }
            })
    }
    
    func getQuestionByTypeAndLevel(with params: getQuestionByTypeAndLevelRequestParams) {
        request?.cancel()
        
        request = catalogService.getQuestionByTypeAndLevel(with: params)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result.result {
                case "error":
                    self.events.send(.errorMessage(result.error))
                case "success":
                    self.events.send(.questionsLoaded(result))
                default:
                    break
                }
            })
    }
  
    
}

enum CatalogProviderEvent {
    case error(_ error: ApiError)
    case errorMessage(_ errorMessage: String?)
    case success
    case dataLoaded(_ result: getInstrumentsByTypeResponse)
    case categoriesLoaded(_ response: GetCategoriesResponse)
    case subCategoriesLoaded(_ response: GetSubCategoriesResponse)
    case loginSuccsess(_ response: LoginResponse)
    case profileDataLoaded(_ response: GetProfileDataResponse)
    case registerSuccess(_ response: RegisterResponse)
    case typesLoaded(_ response: GetTypesResponse)
    case questionsLoaded(_ response: GetQuestionByTypeAndLevelResponse)
}
