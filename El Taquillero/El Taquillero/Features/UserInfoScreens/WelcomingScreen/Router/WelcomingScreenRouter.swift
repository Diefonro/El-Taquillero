//
//  WelcomingScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class WelcomingScreenRouter {
    
    weak var view: WelcomingScreenVC?
    
    func navigateToLogin() {
        if let loginScreenVC = UIStoryboard(name: LoginScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: LoginScreenVC.identifier) as? LoginScreenVC {
            loginScreenVC.modalPresentationStyle = .fullScreen
            loginScreenVC.modalTransitionStyle = .coverVertical
            
            self.view?.present(loginScreenVC, animated: true, completion: nil)
        }
    }
    
    func navigateToSignUp() {
        if let signUpScreen = UIStoryboard(name: SignUpScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: SignUpScreenVC.identifier) as? SignUpScreenVC {
            signUpScreen.modalPresentationStyle = .fullScreen
            signUpScreen.modalTransitionStyle = .coverVertical
            
            self.view?.present(signUpScreen, animated: true, completion: nil)
        }

    }
}
