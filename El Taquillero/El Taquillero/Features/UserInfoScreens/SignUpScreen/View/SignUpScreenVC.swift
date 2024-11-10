//
//  SignUpScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class SignUpScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "SignUpScreen"
    static var identifier = "SignUpScreenVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
