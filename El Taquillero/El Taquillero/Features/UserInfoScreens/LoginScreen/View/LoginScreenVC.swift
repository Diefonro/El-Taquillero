//
//  LoginScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class LoginScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "LoginScreen"
    static var identifier = "LoginScreenVC"
    
    @IBOutlet weak var containerVIew: UIView!
    
    //MARK: ScrollView Outlets
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    //MARK: BackButton Outlet
    @IBOutlet weak var backButtonView: UIView!
    
    //MARK: WelcomeView Outlets
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var welcomeDescriptionLabel: UILabel!
    
    //MARK: TextFields
    //MARK: Username TextField Outlets
    @IBOutlet weak var usernameTextFieldWrapper: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernamePlaceholder: UILabel!
    
    @IBOutlet weak var usernameErrorView: UIView!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    //MARK: Password TextField Outlets
    @IBOutlet weak var passwordTextFieldWrapper: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordPlaceholder: UILabel!
    @IBOutlet weak var passwordLockImageView: UIImageView!
    
    @IBOutlet weak var passwordErrorView: UIView!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    //MARK: SeparatorView Outlet
    @IBOutlet weak var separatorLabel: UILabel!
    
    //MARK: SocialLogin Buttons Outlets
    @IBOutlet weak var appleLoginButtonWrapper: UIView!
    @IBOutlet weak var appleLoginLabel: UILabel!
    
    @IBOutlet weak var linkedInLoginButtonWrapper: UIView!
    @IBOutlet weak var linkedInLoginLabel: UILabel!
    
    @IBOutlet weak var googleLoginButtonWrapper: UIView!
    @IBOutlet weak var googleLoginLabel: UILabel!
    
    //MARK: SubmitButton Outlets
    @IBOutlet weak var submitButtonWrapper: UIView!
    @IBOutlet weak var submitButtonLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    
    //MARK: TextFields Logic
    var isPasswordHidden = false {
        didSet {
            self.passwordTextField.isSecureTextEntry = isPasswordHidden
            let imageName = isPasswordHidden ? "eye" : "eye.slash"
            self.passwordLockImageView.image = UIImage(systemName: imageName)
        }
    }
    
    var isUsernameValid: Bool = false
    var isPasswordValid: Bool = false
    
    var type: TextFieldType = .username
    var onEndEditing: (() -> Void)?
    var onEditing: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    func setupUI() {
        self.backButtonView.roundAllCorners(cornerRadius: 25)
        self.applyBorders(views: [self.usernameTextFieldWrapper, self.passwordTextFieldWrapper])
        self.roundCorner(views: [self.usernameTextFieldWrapper, self.passwordTextFieldWrapper, self.appleLoginButtonWrapper, self.linkedInLoginButtonWrapper, self.googleLoginButtonWrapper, self.submitButtonWrapper])
        self.setupLabels()
        self.configureTextFields()
    }
    
    func setupLabels() {
        self.welcomeTextLabel.text = String(localized: "LOGIN_SCREEN_WELCOME_TEXT")
        self.welcomeDescriptionLabel.text = String(localized: "LOGIN_SCREEN_WELCOME_DESCRIPTION")
        
        self.usernamePlaceholder.text = String(localized: "TEXTFIELD_USERNAME_PLACEHOLDER")
        self.passwordPlaceholder.text = String(localized: "TEXTFIELD_PASSWORD_PLACEHOLDER")
        self.forgotPasswordLabel.text = String(localized: "LOGIN_SCREEN_FORGOT_PASSWORD_CAPTION")
        
        self.separatorLabel.text = String(localized: "LOGIN_SCREEN_LOGIN_OPTIONS")
        
        self.appleLoginLabel.text = String(localized: "LOGIN_SCREEN_APPLE_LOGIN_CAPTION")
        self.linkedInLoginLabel.text = String(localized: "LOGIN_SCREEN_LINKEDIN_LOGIN_CAPTION")
        self.googleLoginLabel.text = String(localized: "LOGIN_SCREEN_GOOGLE_LOGIN_CAPTION")
        
        self.submitButtonLabel.text = String(localized: "LOGIN_SCREEN_SUBMIT_BUTTON_CAPTION")
        
        self.setupFonts(labels: [self.usernamePlaceholder, self.passwordPlaceholder])
        self.setupBoldLabels(labels: [self.appleLoginLabel, self.linkedInLoginLabel, self.googleLoginLabel, self.submitButtonLabel])
        
        self.welcomeTextLabel.font = UIFont(name: "Lato-Black", size: 36)
        self.welcomeDescriptionLabel.font = UIFont(name: "Lato-Regular", size: 20)
        self.usernameErrorLabel.font = UIFont(name: "Lato-Regular", size: 13)
        self.passwordErrorLabel.font = UIFont(name: "Lato-Regular", size: 13)
        self.forgotPasswordLabel.font = UIFont(name: "Lato-Regular", size: 13)
        self.separatorLabel.font = UIFont(name: "Lato-Regular", size: 12)
    }
    
    func setupBoldLabels(labels: [UILabel]) {
        labels.forEach { label in
            label.font = UIFont(name: "Lato-Bold", size: 17)
        }
    }
    
    func setupFonts(labels: [UILabel]) {
        labels.forEach { label in
            label.font = UIFont(name: "Lato-Regular", size: 17)
        }
    }
    
    func applyBorders(views: [UIView]) {
        views.forEach { view in
            view.layer.borderColor = UIColor.etSoftGrayGreen.cgColor
            view.layer.borderWidth = 1
        }
        
        self.googleLoginButtonWrapper.layer.borderColor = UIColor.etSoftGrayGreen.cgColor
        self.googleLoginButtonWrapper.layer.borderWidth = 1
    }
    
    func roundCorner(views: [UIView]) {
        views.forEach { eachView in
            eachView.roundAllCorners(cornerRadius: 18)
        }
    }
    
    func configureTextFields() {
        self.setupTextFields(textFields: [self.passwordTextField, self.usernameTextField])
        passwordLockImageView.isUserInteractionEnabled = true
        passwordLockImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePassword)))
        self.dismissKeyboardWhenTappedAround()

        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.usernameTextField.tag = TextFieldType.username.rawValue
        self.passwordTextField.tag = TextFieldType.password.rawValue
    }
    
    func setupTextFields(textFields: [UITextField]) {
        textFields.forEach { textField in
            textField.font = UIFont(name: "Lato-Regular", size: 17)
            textField.textColor = .darkGray
            textField.borderStyle = .none
        }
    }
    
    @objc func hidePassword() {
        isPasswordHidden.toggle()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        print("Forgot password")
    }
    
    @IBAction func appleLoginButtonAction(_ sender: Any) {
        print("Log In Apple")
    }
    
    @IBAction func linkedInLoginButtonAction(_ sender: Any) {
        print("Log In LinkedIn")
    }
    
    @IBAction func googleLoginButtonAction(_ sender: Any) {
        print("Log In Google")
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        self.checkTextFields()
    }

}
