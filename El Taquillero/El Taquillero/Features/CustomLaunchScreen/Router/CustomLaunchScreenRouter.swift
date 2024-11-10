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
        if let tabBarScreen = UIStoryboard(name: TabBarScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: TabBarScreenVC.identifier) as? TabBarScreenVC {
            tabBarScreen.modalTransitionStyle = .crossDissolve
            tabBarScreen.modalPresentationStyle = .fullScreen
            
            self.view?.present(tabBarScreen, animated: true)
        }
        
//        if let tabBarScreen = UIStoryboard(name: LoginScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: LoginScreenVC.identifier) as? LoginScreenVC {
//            tabBarScreen.modalTransitionStyle = .crossDissolve
//            tabBarScreen.modalPresentationStyle = .fullScreen
//            
//            self.view?.present(tabBarScreen, animated: true)
//        }
    }
}
