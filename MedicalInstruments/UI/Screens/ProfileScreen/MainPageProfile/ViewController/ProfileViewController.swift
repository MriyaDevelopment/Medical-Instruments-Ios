//
//  ProfileViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Combine

final class ProfileViewController<View: ProfileView>: BaseViewController<View> {
    
    private var catalogProvider: CatalogProviderProtocol
    private var cancalables = Set<AnyCancellable>()
    
    var showFirstProfileScreen: VoidClosure?
    var showAlertDialogScreen: VoidClosure?
    var showChallengesScreen: VoidClosure?
    var showQuizScreen: BoolClosure?
        
    init(catalogProvider: CatalogProviderProtocol) {
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showLoader(background: BaseColor.hex_FFFFFF.uiColor(), alfa: 1, presentationStyle: .fullScreen)
        hideNavBar()
        catalogProvider.getProfileData()
        catalogProvider.getResult()
        subscribeForUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Keychain.shared.getUserToken() != nil {
            catalogProvider.getResult()
        }
    }
    
    private func subscribeForUpdates() {
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
        rootView.event.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
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
        case .profileDataLoaded(let response):
            dismissLoader()
            guard let data = response.user?.first else { return }
            rootView.configureProfile(data: data)
        case .getResultLoaded(let response):
            rootView.removeElements()
            rootView.configureBanner(data: response)
        default:
            break
        }
    }
    
    private func onViewEvents(_ event: MainPageViewEvent) {
        switch event {
        case .exitClicked:
            showAlertDialog()
        case .switchToTestClicked:
            showChallengesScreen?()
        case .tryAgainClicked:
            showQuizScreen?(true)
        default:
            break
        }
    }
    
    private func showAlertDialog() {
        
        let alertController = AlertDialogViewController()
        alertController.modalPresentationStyle = .overFullScreen
        alertController.modalTransitionStyle = .crossDissolve
        alertController.yesClicked = { [weak self] in self?.showFirstProfileScreen?() }
        present(alertController, animated: true, completion: nil)
    }
    
}
