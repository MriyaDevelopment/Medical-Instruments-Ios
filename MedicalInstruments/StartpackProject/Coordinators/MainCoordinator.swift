//
//  MainCoordinator.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showMainScreen()
    }
    
    //MARK: Main Module
    private func showMainScreen() {
        let screen = screenFactory.makeMainScreen()
        router.setRootModule(screen, hideBar: true)
    }
}
