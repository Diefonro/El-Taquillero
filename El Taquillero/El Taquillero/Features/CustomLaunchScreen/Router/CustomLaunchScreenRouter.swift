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
        print("Presenting Home Screen...")
    }

}
