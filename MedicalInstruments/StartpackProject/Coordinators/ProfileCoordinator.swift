//
//  ProfileCoordinator.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

final class ProfileCoordinator: BaseCoordinator {
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        if Keychain.shared.getUserToken() != nil {
            showProfileScreen()
        } else {
            showFirstScreen()
        }
    }
    
    //MARK: Profile Module
    private func showProfileScreen() {
        let screen = screenFactory.makeProfileScreen()
        screen.showFirstProfileScreen = { [weak self] in self?.showFirstScreen() }
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showFirstScreen() {
        let screen = screenFactory.makeFirstScreen()
        screen.showAuthScreen = { [weak self] in self?.showAuthScreen() }
        screen.showRegistrScreen = { [weak self] in self?.showRegisterScreen() }
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showAuthScreen() {
        let screen = screenFactory.makeAuthScreen()
        screen.showMainPageProfile = { [weak self] in self?.showProfileScreen() }
        screen.showRegistrScreen = { [weak self] in self?.showRegisterScreen() }
        router.push(screen)
    }
    
    private func showRegisterScreen() {
        let screen = screenFactory.makeRegisterScreen()
        screen.showMainPageProfileScreen = { [weak self] in self?.showProfileScreen() }
        router.push(screen)
    }
}
