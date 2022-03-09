//
//  DI.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

final class Di {
    
    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactoryProtocol
    
    fileprivate let configuration: ConfigurationProtocol
    fileprivate let sessionConfiguration: SessionConfigurationProtocol
    
    fileprivate let requestBuilder: RequestBuilderProtocol
    fileprivate let apiClient: ApiClient
    
    init() {
        
        screenFactory = ScreenFactory()
        coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        
        configuration = Configuration()
        sessionConfiguration = SessionConfiguration()
        
        requestBuilder = RequestBuilder(configuration: configuration)
        
        apiClient = ApiClient(requestBuilder: requestBuilder, configuration: sessionConfiguration.configuration)
        
        screenFactory.di = self
    }
    
    private func clearProviderState() {
        #warning("Set code later")
    }
}

protocol AppFactoryProtocol {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactoryProtocol {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        let router = Router(rootController: rootVC)
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

protocol ScreenFactoryProtocol {
    
    //MARK: Launch
    
    func makeLaunchScreen() -> LaunchScreenViewController<LaunchScreenView>
    
    //MARK: Main
    
    func makeMainScreen() -> MainViewController<MainView>
    
    func makeSubCategoriesScreen() -> SubcategoriesViewController<SubcategoriesView>
    
    //MARK: Challenges
    
    func makeChallengesScreen() -> ChallengesViewController<ChallengesView>
    
    //MARK: Favourites
    
    func makeFavouritesScreen() -> FavouritesViewController<FavouritesView>
    
    //MARK: Profile
    
    func makeProfileScreen() -> ProfileViewController<ProfileView>

}

final class ScreenFactory: ScreenFactoryProtocol {
    

    fileprivate weak var di: Di!
    fileprivate init() {}
    
    //MARK: Launch
    
    func makeLaunchScreen() -> LaunchScreenViewController<LaunchScreenView> {
        LaunchScreenViewController<LaunchScreenView>()
    }
    
    //MARK: Main
    
    func makeMainScreen() -> MainViewController<MainView> {
        MainViewController<MainView>()
    }
    
    func makeSubCategoriesScreen() -> SubcategoriesViewController<SubcategoriesView> {
        SubcategoriesViewController<SubcategoriesView>()
    }
    
    //MARK: Challenges
    
    func makeChallengesScreen() -> ChallengesViewController<ChallengesView> {
        ChallengesViewController<ChallengesView>()
    }
    
    //MARK: Favourites
    
    func makeFavouritesScreen() -> FavouritesViewController<FavouritesView> {
        FavouritesViewController<FavouritesView>()
    }
    
    //MARK: Profile
        
    func makeProfileScreen() -> ProfileViewController<ProfileView> {
        ProfileViewController<ProfileView>()
    }
  
}

protocol CoordinatorFactoryProtocol {
    
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator
    func makeStartCoordinator(router: RouterProtocol) -> StartCoordinator
    func makeTabCoordinator(router: RouterProtocol) -> TabCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let screenFactory: ScreenFactoryProtocol
    
    fileprivate init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeStartCoordinator(router: RouterProtocol) -> StartCoordinator {
        StartCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeTabCoordinator(router: RouterProtocol) -> TabCoordinator {
        let tabBarController = TabBarController()
        return TabCoordinator(tabBarController: tabBarController, router: router, screenFactory: screenFactory)
    }
}
