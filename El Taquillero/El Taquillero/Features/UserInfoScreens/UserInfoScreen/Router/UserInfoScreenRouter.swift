//
//  UserInfoScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class UserInfoScreenRouter {
    
    var view: UserInfoScreenVC?
    
    func navigateToFavoritesScreen() {
        if let favoritesScreen = UIStoryboard(name: FavoritesScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: FavoritesScreenVC.identifier) as? FavoritesScreenVC {
            
            self.view?.navigationController?.pushViewController(favoritesScreen, animated: true)
        }
    }
}
