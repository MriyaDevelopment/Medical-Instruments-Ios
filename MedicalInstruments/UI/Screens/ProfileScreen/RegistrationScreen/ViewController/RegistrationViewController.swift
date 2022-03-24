//
//  RegistrationViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 16.03.2022.
//

import Foundation
import Combine

final class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {
        
    private var catalogProvider: CatalogProviderProtocol
    private var cancalables = Set<AnyCancellable>()
    var showMainPageProfileScreen: VoidClosure?
    
    init(catalogProvider: CatalogProviderProtocol) {
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForUpdates()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Регистрация", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }

    private func subscribeForUpdates() {
        catalogProvider.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
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
        case .registerSuccess(let response):
            dismissLoader()
            guard let token = response.register?.api_token else { return }
            guard let name = response.register?.name else { return }
            Keychain.shared.setUserToken(token)
            Keychain.shared.setUserName(name)
            showMainPageProfileScreen?()
        default:
            break
        }
    }
    
    private func onViewEvents(_ event: RegistrationViewEvents){
        switch event {
        case.registrationButtonClicked:
            showLoader()
            catalogProvider.register(with: RegisterRequestParams(name: rootView.nameInputForm.getValue(),
                                                                 email: rootView.emailInputForm.getValue(),
                                                                 password: rootView.passwordInputForm.getValue(),
                                                                 password_confirmation: rootView.passwordRepeatInputForm.getValue()))
        default:
            break
        }
    }
}
