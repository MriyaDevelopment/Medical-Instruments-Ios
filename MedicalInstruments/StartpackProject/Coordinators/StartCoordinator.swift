//
//  StartCoordinator.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation

final class StartCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showSplash()
    }
    
    private func showSplash() {
        let screen = screenFactory.makeLaunchScreen()
        screen.preparationFinished = { [weak self] in self?.finishFlow?() }

        router.setRootModule(screen, hideBar: true)
    }
}
