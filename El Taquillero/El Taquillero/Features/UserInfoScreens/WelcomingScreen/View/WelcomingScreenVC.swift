//
//  WelcomingScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class WelcomingScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "WelcomingScreen"
    static var identifier = "WelcomingScreenVC"
    
    @IBOutlet weak var welcomingTextLabel: UILabel!
    @IBOutlet weak var welcomingDescriptionLabel: UILabel!
    
    @IBOutlet weak var loginButtonWrapper: UIView!
    @IBOutlet weak var loginButtonCaption: UILabel!
    
    @IBOutlet weak var registerButtonWrapper: UIView!
    @IBOutlet weak var registerButtonCaption: UILabel!
    
    @IBOutlet weak var containedView: UIView!
    
    var presenter : WelcomingScreenPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupLabels()
        setupViews()
    }
    
    
    func setupUserInfoScreen() {
        self.containedView.isHidden = false
        if let userInfoScreen = UIStoryboard(name: UserInfoScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: UserInfoScreenVC.identifier) as? UserInfoScreenVC {
            
            addChild(userInfoScreen)
            userInfoScreen.view.frame = self.containedView.bounds
            self.containedView.addSubview(userInfoScreen.view)
            userInfoScreen.didMove(toParent: self)
        }
    }
    
    
    
    func setupLabels() {
        self.welcomingTextLabel.font = UIFont(name: "Lato-Black", size: 36)
        self.welcomingDescriptionLabel.font = UIFont(name: "Lato-Regular", size: 20)
        self.setupBoldLabels(labels: [self.loginButtonCaption, self.registerButtonCaption])
        
        self.welcomingTextLabel.text = String(localized: "WELCOMING_SCREEN_TEXT")
        self.welcomingDescriptionLabel.text = String(localized: "WELCOMING_SCREEN_DESCRIPTION")
        self.loginButtonCaption.text = String(localized: "LOGIN_BUTTON_CAPTION")
        self.registerButtonCaption.text = String(localized: "SIGNUP_BUTTON_CAPTION")
    }
    
    func setupBoldLabels(labels: [UILabel]) {
        labels.forEach { label in
            label.font = UIFont(name: "Lato-Bold", size: 17)
        }
    }
    
    func setupViews() {
        self.roundCorners(views: [self.loginButtonWrapper, self.registerButtonWrapper])
        self.registerButtonWrapper.layer.borderColor = UIColor.etDarkTeal.cgColor
        self.registerButtonWrapper.layer.borderWidth = 1
    }
    
    func roundCorners(views: [UIView]) {
        views.forEach { view in
            view.roundAllCorners(cornerRadius: 18)
        }
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        print("Login")
        self.presenter.readyToNavigateToLogin()
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        print("Register")
        self.presenter.readyToNavigateToSignUp()
    }
}
