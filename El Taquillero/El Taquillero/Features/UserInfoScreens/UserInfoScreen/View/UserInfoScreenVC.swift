//
//  UserInfoScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class UserInfoScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "UserInfoScreen"
    static var identifier = "UserInfoScreenVC"
    
    var presenter: UserInfoScreenPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigateToFavoritesScreen() {
        self.presenter.readyToNavigateToFavoritesScreen()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.navigateToFavoritesScreen()
    }
}
