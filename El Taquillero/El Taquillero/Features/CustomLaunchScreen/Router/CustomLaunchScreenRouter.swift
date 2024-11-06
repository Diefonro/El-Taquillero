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
            self.view?.present(homeScreenVC, animated: true)
        }
    }
}
