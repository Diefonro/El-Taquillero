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
        self.checkIfTheresSession()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        setupLabels()
        setupViews()
    }
    
    func checkIfTheresSession() {
        let isUserLoggedIn = UserDefaults.isLoggedIn()
        
        if isUserLoggedIn {
            if let email = SessionCRUDFunctions.shared.fetchEmail() {
                
            } else {
                print("No email found to continue session")
                
            }
        } else {
            print("No active session")
        }
    }
    
    
    func setupUserInfoScreen(email: String) {
        self.containedView.isHidden = false
        if let userInfoScreen = UIStoryboard(name: UserInfoScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: UserInfoScreenVC.identifier) as? UserInfoScreenVC {
            
            let userData = SessionCRUDFunctions.shared.fetchUser(withEmail: email)
            userInfoScreen.name = userData?.name
            userInfoScreen.surname = userData?.surname
            userInfoScreen.phone = userData?.phone
            userInfoScreen.email = userData?.email
           
            print("Setting up UserInfoScreen with email: \(email)")

            
            userInfoScreen.onLogOutConfirmed = { [weak self] in
                userInfoScreen.clearData()
                self?.setUpWelcomingAfterLogOut()
            }
            
            let router = UserInfoScreenRouter()
            router.view = userInfoScreen
            let presenter = UserInfoScreenPresenter(view: userInfoScreen, router: router)
            userInfoScreen.presenter = presenter
            
            addChild(userInfoScreen)
            userInfoScreen.view.frame = self.containedView.bounds
            self.containedView.addSubview(userInfoScreen.view)
            userInfoScreen.didMove(toParent: self)
        }
    }
    
    func setUpWelcomingAfterLogOut() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    
        self.containedView.isHidden = true
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
