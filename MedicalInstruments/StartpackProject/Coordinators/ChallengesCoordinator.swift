//
//  ChallnegesCoordinator.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

final class ChallengesCoordinator: BaseCoordinator {
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    private let switchToProfileTab: VoidClosure
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol, switchToProfileTab: @escaping VoidClosure) {
        self.screenFactory = screenFactory
        self.router = router
        self.switchToProfileTab = switchToProfileTab
    }
    
    override func start() {
        showChallengesScreen()
    }
    
    //MARK: Challenges Module
    private func showChallengesScreen() {
        let screen = screenFactory.makeChallengesScreen()
        screen.showChangeCategoriesScreen = { [weak self] dificultId in
            self?.showChangeCategoriesScreen(dificultId: dificultId)
        }
        screen.showRegistrScreen = { [weak self] in self?.switchToProfileTab() }
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showChangeCategoriesScreen(dificultId: Int) {
        let screen = screenFactory.makeChangeCategoriesScreen(dificultId: dificultId)
        screen.showQuizScreen = { [weak self] (id, types) in
            self?.showQuizScreen(id: id, types: types)
        }
        router.push(screen, animated: true)
    }
    
    private func showQuizScreen(id: Int, types: String) {
        let screen = screenFactory.makeQuizScreen(id: id, types: types, isLastTest: false)
        screen.showRootScreen = { [weak self] in self?.showChallengesScreen()}
        router.push(screen, animated: true)
    }
}
