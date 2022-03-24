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
    
    fileprivate let catalogService: CatalogServiceProtocol
    fileprivate let catalogProvider: CatalogProviderProtocol
    
    init() {
        
        screenFactory = ScreenFactory()
        coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        
        configuration = Configuration()
        sessionConfiguration = SessionConfiguration()
        
        requestBuilder = RequestBuilder(configuration: configuration)
        
        apiClient = ApiClient(requestBuilder: requestBuilder, configuration: sessionConfiguration.configuration)
        
        catalogService = CatalogService(apiClient: apiClient)
        catalogProvider = CatalogProviderImpl(catalogService: catalogService)
        
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
    
    func makeInstrumentListScreen(type: String, isMainCategory: Bool) -> InstrumentListViewController<InstrumentListView>
    
    //MARK: Challenges
    
    func makeChallengesScreen() -> ChallengesViewController<ChallengesView>
    
    func makeChangeCategoriesScreen(dificultId: Int) -> ChangeCategoriesViewController<ChangeCategoriesView>
    
    func makeQuizScreen(id: Int, types: String, isLastTest: Bool) -> QuizViewController<QuizView>
    
    //MARK: Favourites
    
    func makeFavouritesScreen() -> FavouritesViewController<FavouritesView>
    
    //MARK: Profile
    
    func makeProfileScreen() -> ProfileViewController<ProfileView>
    
    func makeFirstScreen() -> FirstViewController<FirstView>
    
    func makeAuthScreen() -> AuthViewController<AuthView>
    
    func makeRegisterScreen() -> RegistrationViewController<RegistrationView>

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
        MainViewController<MainView>(catalogProvider: di.catalogProvider)
    }
    
    func makeSubCategoriesScreen() -> SubcategoriesViewController<SubcategoriesView> {
        SubcategoriesViewController<SubcategoriesView>(catalogProvider: di.catalogProvider)
    }
    
    func makeInstrumentListScreen(type: String, isMainCategory: Bool) -> InstrumentListViewController<InstrumentListView> {
        InstrumentListViewController<InstrumentListView>(catalopProvider: di.catalogProvider, type: type, isMainCategory: isMainCategory)
    }
    
    //MARK: Challenges
    
    func makeChallengesScreen() -> ChallengesViewController<ChallengesView> {
        ChallengesViewController<ChallengesView>()
    }
    
    func makeChangeCategoriesScreen(dificultId: Int) -> ChangeCategoriesViewController<ChangeCategoriesView> {
        ChangeCategoriesViewController<ChangeCategoriesView>(dificultId: dificultId, catalogProvider: di.catalogProvider)
    }
    
    func makeQuizScreen(id: Int, types: String, isLastTest: Bool = false) -> QuizViewController<QuizView> {
        QuizViewController<QuizView>(id: id, types: types, catalogProvider: di.catalogProvider, isLastTest: isLastTest)
    }
    
    //MARK: Favourites
    
    func makeFavouritesScreen() -> FavouritesViewController<FavouritesView> {
        FavouritesViewController<FavouritesView>(catalogProvider: di.catalogProvider)
    }
    
    //MARK: Profile
        
    func makeProfileScreen() -> ProfileViewController<ProfileView> {
        ProfileViewController<ProfileView>(catalogProvider: di.catalogProvider)
    }
    
    func makeFirstScreen() -> FirstViewController<FirstView> {
        FirstViewController<FirstView>()
    }
    
    func makeAuthScreen() -> AuthViewController<AuthView> {
        AuthViewController<AuthView>(catalogProvider: di.catalogProvider)
    }
    
    func makeRegisterScreen() -> RegistrationViewController<RegistrationView> {
        RegistrationViewController<RegistrationView>(catalogProvider: di.catalogProvider)
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
