//
//  ChallengesViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation
import Combine

final class ChallengesViewController<View: ChallengesView>: BaseViewController<View> {
        
    var showChangeCategoriesScreen: IntClosure?
    var showRegistrScreen: VoidClosure?
    private var cancalables = Set<AnyCancellable>()
    private let catalogProvider: CatalogProviderProtocol
    
    init(catalogProvider: CatalogProviderProtocol) {
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        subscribeForUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.showView()
        showPreloader()
        catalogProvider.getLevels()
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: ChalengesViewEvent){
        switch event {
        case .cellClicked(let id):
            showChangeCategoriesScreen?(id)
        }
        
    }
    
    private func onProviderEvents(_ event: CatalogProviderEvent){
        switch event {
        case .error(let error):
            dismissPreloader()
            showErrorWithMessage?(error.errorDescription)
        case .errorMessage(let errorMessage):
            dismissPreloader()
            guard let message = errorMessage else { return }
            showErrorWithMessage?(message)
        case .levelsLoaded(let response):
            dismissPreloader()
            guard let levels = response.levels else {return}
            rootView.configure(levels: levels)
        default:
            break
        }
    }
}
