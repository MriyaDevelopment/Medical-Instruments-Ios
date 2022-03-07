//
//  ChallnegesCoordinator.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

final class ChallengesCoordinator: BaseCoordinator {
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showChallengesScreen()
    }
    
    //MARK: Challenges Module
    private func showChallengesScreen() {
        let screen = screenFactory.makeChallengesScreen()
        router.setRootModule(screen, hideBar: true)
    }
}
