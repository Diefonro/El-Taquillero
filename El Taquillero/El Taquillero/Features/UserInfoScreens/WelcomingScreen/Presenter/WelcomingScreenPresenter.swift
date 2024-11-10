//
//  WelcomingScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class WelcomingScreenPresenter {
    
    var view: WelcomingScreenVC
    var router: WelcomingScreenRouter
    
    init(view: WelcomingScreenVC, router: WelcomingScreenRouter) {
        self.view = view
        self.router = router
    }
    
    func readyToNavigateToLogin() {
        self.router.navigateToLogin()
    }
    
    func readyToNavigateToSignUp() {
        self.router.navigateToSignUp()
    }
}
