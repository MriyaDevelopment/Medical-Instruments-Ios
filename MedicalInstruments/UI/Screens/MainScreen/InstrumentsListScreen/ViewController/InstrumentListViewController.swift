//
//  InstrumentListViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import Foundation
import Combine

final class InstrumentListViewController<View: InstrumentListView>: BaseViewController<View> {
        
    private var catalopProvider: CatalogProviderProtocol
    private var cancalables = Set<AnyCancellable>()
    
    init(catalopProvider: CatalogProviderProtocol) {
        self.catalopProvider = catalopProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeForUpdates()
        catalopProvider.getInstrumentsByType(param: getInstrumentsByTypeRequestParams(type: "gynecology"))
        showLoader()
    }
    
    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Тема: Общая хирургия", subTitle: "Раздел: Соединяющие")
        navBar.addItem(titleView, toPosition: .title)
    }
    
    private func subscribeForUpdates() {
        catalopProvider.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: CatalogProviderEvent){
        switch event {
        case .error(let error):
            dismissLoader()
            showErrorWithMessage?(error.errorDescription)
        case .errorMessage(let errorMessage):
            dismissLoader()
            guard let message = errorMessage else { return }
            showErrorWithMessage?(message)
        case .dataLoaded(let response):
            dismissLoader()
            guard let data = response.instruments else { return }
            rootView.configure(instruments: data)
        default:
            break
        }
        
    }
    
}
