//
//  TabBarScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class TabBarScreenVC: UITabBarController, StoryboardInfo {
    
    static var storyboard = "TabBarScreen"
    static var identifier = "TabBarScreenVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureControllers()
        self.configureTabBarAppearance()
    }
    
    func configureControllers() {
        if let homeScreen = UIStoryboard(name: HomeScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: HomeScreenVC.identifier) as? HomeScreenVC, let welcomingScreen = UIStoryboard(name: WelcomingScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: WelcomingScreenVC.identifier) as? WelcomingScreenVC {
            
            homeScreen.title =  String(localized: "HOME_SCREEN_CAPTION")
            homeScreen.tabBarItem.image = UIImage(systemName: "movieclapper.fill")?.withTintColor(.etTeal)
            
            let homeInteractor = HomeScreenInteractor()
            let homeRouter = HomeScreenRouter()
            homeRouter.view = homeScreen
            let homePresenter = HomeScreenPresenter(view: homeScreen, interactor: homeInteractor, router: homeRouter)
            homeScreen.presenter = homePresenter
            
            let welcomingRouter = WelcomingScreenRouter()
            welcomingRouter.view = welcomingScreen
            let welcomingPresenter = WelcomingScreenPresenter(view: welcomingScreen, router: welcomingRouter)
            welcomingScreen.presenter = welcomingPresenter
            
            welcomingScreen.title = String(localized: "USER_INFO_SCREEN_CAPTION")
            welcomingScreen.tabBarItem.image = UIImage(systemName: "person.fill")?.withTintColor(.etTeal)

            let homeNavController = UINavigationController(rootViewController: homeScreen)
            let welcomingNavController = UINavigationController(rootViewController: welcomingScreen)
            
            viewControllers = [homeNavController, welcomingNavController]
        }
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = .etTeal
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .etDarkTeal
        itemAppearance.selected.iconColor = .etPorcelain
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.etDarkTeal]
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.etPorcelain]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
