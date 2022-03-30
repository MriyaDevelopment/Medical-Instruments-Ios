//
//  FavouritesViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation
import Combine

final class FavouritesViewController<View: FavouritesView>: BaseViewController<View> {
        
    private let catalogProvider: CatalogProviderProtocol
    private var cancalables = Set<AnyCancellable>()
    
    init(catalogProvider: CatalogProviderProtocol) {
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPreloader()
        hideNavBar()
        subscribeForUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Keychain.shared.getUserToken() != nil {
            catalogProvider.getFavourites()
        } else {
            rootView.configureEmptyView()
            rootView.configure(instruments: [])
        }
        super.viewWillAppear(animated)
    }
    
    private func subscribeForUpdates() {
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
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
        case .favouritesLoaded(let response):
            dismissPreloader()
            guard let data = response.instruments else { return }
            rootView.configure(instruments: data)
        case .success:
            dismissPreloader()
            catalogProvider.getFavourites()
        default:
            break
        }
    }
    
    private func onViewEvents(_ Event: FavouritesViewEvent) {
        switch Event {
        case .setLike(let id, let isSurgery):
            catalogProvider.setLike(with: SetLikeRequestParams(instrument_id: String(id), is_surgery: String(isSurgery)))
        case .removeLike(let id, let isSurgery):
            showPreloader()
            catalogProvider.removeLike(with: RemoveLikeRequestParams(instrument_id: String(id), is_surgery: String(isSurgery)))
        }
    }
}
