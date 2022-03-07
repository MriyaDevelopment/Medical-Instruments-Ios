//
//  FavouritesViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

final class FavouritesCoordinator: BaseCoordinator {
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showFavouritesScreen()
    }
    
    //MARK: Favourites Module
    private func showFavouritesScreen() {
        let screen = screenFactory.makeFavouritesScreen()
        router.setRootModule(screen, hideBar: true)
    }
}
