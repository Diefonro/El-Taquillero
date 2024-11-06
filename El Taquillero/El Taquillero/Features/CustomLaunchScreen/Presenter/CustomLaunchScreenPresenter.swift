//
//  CustomLaunchScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol CustomLaunchScreenPresenterProtocol {
    func viewUIReady()
}

class CustomLaunchScreenPresenter: CustomLaunchScreenPresenterProtocol {
    
    weak var view: CustomLaunchScreenVC?
    var router: CustomLaunchScreenRouterProtocol?
    
    func viewUIReady() {
        router?.presentHomeScreen()
    }
    
}

