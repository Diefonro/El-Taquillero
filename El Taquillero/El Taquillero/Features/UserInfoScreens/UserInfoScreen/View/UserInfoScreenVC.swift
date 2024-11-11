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
    
    @IBOutlet weak var yourDetailsTitle: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSurname: UILabel!
    
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var favoritesTitle: UILabel!
    
    var presenter: UserInfoScreenPresenter!
    
    var onLogOutConfirmed: (() -> Void)?
    
    var name: String?
    var surname: String?
    var phone: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.userName.text = self.name
        self.userSurname.text = self.surname
        self.userPhone.text = self.phone
        self.userEmail.text = self.email
    }
    
    func clearData() {
        self.userName.text = ""
        self.userSurname.text = ""
        self.userPhone.text = ""
        self.userEmail.text = ""
    }
    
    func navigateToFavoritesScreen() {
        self.presenter.readyToNavigateToFavoritesScreen()
    }
    
    func navigateToConfirmLogOut() {
        self.presenter.readyToNavigateToConfirmLogOut()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.navigateToFavoritesScreen()
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        self.navigateToConfirmLogOut()
    }
}
