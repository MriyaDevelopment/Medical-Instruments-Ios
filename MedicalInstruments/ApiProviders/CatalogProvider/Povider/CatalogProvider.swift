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
}

final class CatalogProviderImpl: CatalogProviderProtocol {
    let events = PassthroughSubject<CatalogProviderEvent, Never>()
    
    private let catalogService: CatalogServiceProtocol
    private var request: AnyCancellable?

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
        request?.cancel()
        
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

    
}

enum CatalogProviderEvent {
    case error(_ error: ApiError)
    case errorMessage(_ errorMessage: String?)
    case success
    case dataLoaded(_ result: getInstrumentsByTypeResponse)
    case categoriesLoaded(_ response: GetCategoriesResponse)
    case subCategoriesLoaded(_ response: GetSubCategoriesResponse)
}
