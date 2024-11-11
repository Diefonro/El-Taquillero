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
            favoritesScreen.title = "Favorites"
            
            self.view?.navigationController?.pushViewController(favoritesScreen, animated: true)
        }
    }
    
    func navigateToConfirmLogOut() {
        if let confirmLogOutScreen = UIStoryboard(name: ConfirmLogOutScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: ConfirmLogOutScreenVC.identifier) as? ConfirmLogOutScreenVC {
            
            confirmLogOutScreen.onLogOutConfirmedPressed = { [weak self] in
                confirmLogOutScreen.dismiss(animated: true)
                FirebaseGlobalFunctions.logOutUser { result in
                    switch result {
                    case .success():
                        UserDefaults.setLoggedIn(false)
                        self?.view?.onLogOutConfirmed?()
                    case .failure(let error):
                        print("Failed to log out: \(error.localizedDescription)")
                    }
                }
                self?.view?.dismiss(animated: true)
            }
            
            confirmLogOutScreen.modalPresentationStyle = .pageSheet
            
            if let sheetController = confirmLogOutScreen.sheetPresentationController {
                sheetController.detents = [
                    .custom(resolver: { context in
                        return UIScreen.main.bounds.height * 0.4
                    })
                ]
            }
            
            confirmLogOutScreen.isModalInPresentation = true
            self.view?.present(confirmLogOutScreen, animated: true)
        }
    }
}
