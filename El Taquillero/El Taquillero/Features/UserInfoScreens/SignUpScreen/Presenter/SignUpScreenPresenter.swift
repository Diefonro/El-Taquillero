//
//  SignUpScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class SignUpScreenPresenter {
    var view: SignUpScreenVC?
    var router: SignUpScreenRouter?
    
    init(view: SignUpScreenVC, router: SignUpScreenRouter) {
        self.view = view
        self.router = router
    }
    
    func readyToPopUpVerifyScreen(userMail: String) {
        self.router?.popUpVerifyEmailScreen(userMail: userMail)
    }
}
