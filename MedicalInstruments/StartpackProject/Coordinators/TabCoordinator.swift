//
//  TabCoordinator.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit


final class TabCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    private let tabBarController: UITabBarController
    
//MARK: Uncomment this closures when need to transfer through tabs in tabbar

//    lazy var switchToChallengesTab = ({
//        self.tabBarController.selectedIndex = 1
//    })
//
//    lazy var switchToFavouritesTab = ({
//        self.tabBarController.selectedIndex = 2
//    })
//
//    lazy var switchToProfileTab = ({
//        self.tabBarController.selectedIndex = 3
//    })
    
    init(tabBarController: UITabBarController, router: RouterProtocol, screenFactory: ScreenFactoryProtocol ) {
        self.tabBarController = tabBarController
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        
        let selectedItemTitle: [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_5B67CA.uiColor(),
             NSAttributedString.Key.font: MainFont.semiBold(size: 12)]
        
        let unselectedItemTitle: [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_A5A7AD.uiColor(),
             NSAttributedString.Key.font: MainFont.semiBold(size: 12)]
        
        //MARK: Main
        let mainNavigationController = UINavigationController()
        let mainBarItem = UITabBarItem(title: titlesTabBarItem.main.rawValue,
                                       image: AppIcons.getIcon(.i_main),
                                       selectedImage: AppIcons.getIcon(.i_main_selected).setColor(BaseColor.hex_5B67CA.uiColor()))
        mainNavigationController.tabBarItem = mainBarItem
        let mainRouter = Router(rootController: mainNavigationController)
        let mainCoordinator = MainCoordinator(router: mainRouter, screenFactory: screenFactory)
        
        mainBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
        mainBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        //MARK: Challenges
        let challengesNavigationController = UINavigationController()
        let challengesBarItem = UITabBarItem(title: titlesTabBarItem.catalog.rawValue,
                                        image: AppIcons.getIcon(.i_challenges),
                                        selectedImage: AppIcons.getIcon(.i_challenges))
        challengesNavigationController.tabBarItem = challengesBarItem
        let challengesRouter = Router(rootController: challengesNavigationController)
        let challengesCoordinator = ChallengesCoordinator(router: challengesRouter, screenFactory: screenFactory)
        
        challengesBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
        challengesBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        
        //MARK: Favourites
        let favouritesNavigationController = UINavigationController()
        let favouritesBarItem = UITabBarItem(title: titlesTabBarItem.service.rawValue,
                                       image: AppIcons.getIcon(.i_favourites),
                                       selectedImage: AppIcons.getIcon(.i_favourites).setColor(BaseColor.hex_5B67CA.uiColor()))
        favouritesNavigationController.tabBarItem = favouritesBarItem
        let favouritesRouter = Router(rootController: favouritesNavigationController)
        let favouritesCoordinator = FavouritesCoordinator(router: favouritesRouter, screenFactory: screenFactory)
        
        favouritesBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
        favouritesBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        //MARK: Profile
        let profileNavigationController = UINavigationController()
        let profileBarItem = UITabBarItem(title: titlesTabBarItem.profile.rawValue,
                                          image: AppIcons.getIcon(.i_profile),
                                          selectedImage: AppIcons.getIcon(.i_profile).setColor(BaseColor.hex_5B67CA.uiColor()))
        profileNavigationController.tabBarItem = profileBarItem
        let profileRouter = Router(rootController: profileNavigationController)
        let profileCoordinator = ProfileCoordinator(router: profileRouter, screenFactory: screenFactory)
        
        profileBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
        profileBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        tabBarController.viewControllers = [
            mainNavigationController,
            challengesNavigationController,
            favouritesNavigationController,
            profileNavigationController
        ]
        
        tabBarController.tabBar.tintColor = BaseColor.hex_5B67CA.uiColor()
        
        tabBarController.modalPresentationStyle = .fullScreen
        router.present(tabBarController, animated: false)
        
        mainCoordinator.start()
        challengesCoordinator.start()
        favouritesCoordinator.start()
        profileCoordinator.start()

        self.addDependency(mainCoordinator)
        self.addDependency(challengesCoordinator)
        self.addDependency(favouritesCoordinator)
        self.addDependency(profileCoordinator)
        
        tabBarController.selectedIndex = 0
    }
    
    enum titlesTabBarItem: String {
        case main = "Главная"
        case catalog = "Испытания"
        case service = "Избранное"
        case profile = "Профиль"
    }

}
