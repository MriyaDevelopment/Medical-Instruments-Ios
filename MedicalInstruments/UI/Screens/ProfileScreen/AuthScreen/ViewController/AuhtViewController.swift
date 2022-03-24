//
//  AuhtViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import Foundation
import Combine

final class AuthViewController<View: AuthView>: BaseViewController<View> {
    
    private var catalogProvider: CatalogProviderProtocol
    private var cancalables = Set<AnyCancellable>()
    
    var showMainPageProfile: VoidClosure?
    var showRegistrScreen: VoidClosure?
        
    init(catalogProvider: CatalogProviderProtocol) {
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeForUpdates()
    }
    
    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Вход", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }

    private func subscribeForUpdates() {
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onProviderEvents(_ event: CatalogProviderEvent) {
        switch event {
        case .error(let error):
            dismissLoader()
            showErrorWithMessage?(error.errorDescription)
        case .errorMessage(let errorMessage):
            dismissLoader()
            guard let message = errorMessage else { return }
            showErrorWithMessage?(message)
        case .loginSuccsess(let response):
            dismissLoader()
            guard let token = response.user?.api_token else { return }
            guard let name = response.user?.name else { return }
            Keychain.shared.setUserToken(token)
            Keychain.shared.setUserName(name)
            showMainPageProfile?()
        default:
            break
        }
    }
    
    private func onViewEvents(_ event: AuthViewEvent) {
        switch event {
        case .authButtonClicked:
            showLoader()
            
            catalogProvider.login(with: LoginRequestParams(email: rootView.emailInputForm.getValue(),
                                                           password: rootView.passwordInputForm.getValue()))
        case .regButtonClicked:
            showRegistrScreen?()
        default:
            break
        }
    }

}
