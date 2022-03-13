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
        screen.showSubcategories = { [weak self] in
            self?.showSubcategories()
        }
        screen.showInstrumentList = { [weak self] type, isMain in
            self?.showInstrumentListScreen(type: type, isMain: isMain)
        }
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showSubcategories() {
        let screen = screenFactory.makeSubCategoriesScreen()
        screen.showInstrumentListScreen = { [weak self] type, isMain in
            self?.showInstrumentListScreen(type: type, isMain: isMain)
        }
        router.push(screen, animated: true)
    }
    
    private func showInstrumentListScreen(type: String, isMain: Bool) {
        let screen = screenFactory.makeInstrumentListScreen(type: type, isMainCategory: isMain)
        router.push(screen, animated: true)
    }
}
