//
//  CustomLaunchScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol CustomLaunchScreenRouterProtocol {
    func presentHomeScreen()
}

class CustomLaunchScreenRouter: CustomLaunchScreenRouterProtocol {
    
    weak var view: CustomLaunchScreenVC?
    
    func presentHomeScreen() {
        if let homeScreenVC = UIStoryboard(name: HomeScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: HomeScreenVC.identifier) as? HomeScreenVC {
            homeScreenVC.modalPresentationStyle = .fullScreen
            homeScreenVC.modalTransitionStyle = .crossDissolve
            
            let interactor = HomeScreenInteractor()
            let router = HomeScreenRouter()
            
            let presenter = HomeScreenPresenter(view: homeScreenVC, interactor: interactor, router: router)
            
            homeScreenVC.presenter = presenter
            
            self.view?.present(homeScreenVC, animated: true)
        }
    }
}
