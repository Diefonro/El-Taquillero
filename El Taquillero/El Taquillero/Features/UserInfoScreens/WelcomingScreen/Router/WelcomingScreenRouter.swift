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
            
            loginScreenVC.onLoginSucceed = { [weak self] in
                self?.view?.setupUserInfoScreen()
            }
            
            loginScreenVC.modalPresentationStyle = .overFullScreen
            loginScreenVC.modalTransitionStyle = .coverVertical
            
            self.view?.present(loginScreenVC, animated: true, completion: nil)
        }
    }
    
    func navigateToSignUp() {
        if let signUpScreen = UIStoryboard(name: SignUpScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: SignUpScreenVC.identifier) as? SignUpScreenVC {
            
            signUpScreen.onSignUpSuccessfully = { [weak self] in
                self?.view?.setupUserInfoScreen()
            }
            
            signUpScreen.modalPresentationStyle = .overFullScreen
            signUpScreen.modalTransitionStyle = .coverVertical
            
            let router = SignUpScreenRouter()
            router.view = signUpScreen
            let presenter = SignUpScreenPresenter(view: signUpScreen, router: router)
            signUpScreen.presenter = presenter
            
            self.view?.present(signUpScreen, animated: true, completion: nil)
        }
    }
}
