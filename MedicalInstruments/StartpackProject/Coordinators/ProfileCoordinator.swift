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
        showProfileScreen()
    }
    
    //MARK: Profile Module
    private func showProfileScreen() {
        let screen = screenFactory.makeProfileScreen()
        router.setRootModule(screen, hideBar: true)
    }
}
