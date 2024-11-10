//
//  SignUpScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class SignUpScreenRouter {
    var view: SignUpScreenVC?
    
    func popUpVerifyEmailScreen(userMail: String) {
        
        if let verifyEmailScreen = UIStoryboard(name: VerifyEmailScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: VerifyEmailScreenVC.identifier) as? VerifyEmailScreenVC {
            
            verifyEmailScreen.userMail = userMail
            verifyEmailScreen.onEmailVerified = { [weak self] in
                self?.view?.dismiss(animated: true)
            }
            
            verifyEmailScreen.modalPresentationStyle = .pageSheet
            
            if let sheetController = verifyEmailScreen.sheetPresentationController {
                sheetController.detents = [
                    .custom(resolver: { context in
                        return UIScreen.main.bounds.height * 0.4
                    })
                ]
            }
            
            verifyEmailScreen.isModalInPresentation = true
            self.view?.present(verifyEmailScreen, animated: true)
        }
    }
}
