//
//  UserInfoScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class UserInfoScreenPresenter {
    
    var view: UserInfoScreenVC?
    var router: UserInfoScreenRouter?
    
    init(view: UserInfoScreenVC?, router: UserInfoScreenRouter?) {
        self.view = view
        self.router = router
    }
    
    func readyToNavigateToFavoritesScreen() {
        self.router?.navigateToFavoritesScreen()
    }
    
    func readyToNavigateToConfirmLogOut() {
        self.router?.navigateToConfirmLogOut()
    }
}
