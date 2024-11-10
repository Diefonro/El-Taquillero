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
    
    //MARK: BackButton Outlet
    @IBOutlet weak var backButtonViewWrapper: UIView!
    
    //MARK: ScrollView Outlet
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: SignUpView Outlets
    @IBOutlet weak var signUpTitleCaption: UILabel!
    @IBOutlet weak var signUpDescriptionCaption: UILabel!
    
    //MARK: TextFields
    //MARK: Name Outlets
    @IBOutlet weak var enterDetailsTitle: UILabel!
    @IBOutlet weak var enterDetailsDescription: UILabel!
    
    @IBOutlet weak var usernameTextFieldWrapper: UIView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var usernamePlaceholder: UILabel!
    
    @IBOutlet weak var usernameErrorView: UIView!
    @IBOutlet weak var usernameErrorCaption: UILabel!
    
    //MARK: Surname Outlets
    @IBOutlet weak var surnameTextfieldWrapper: UIView!
    @IBOutlet weak var surnameTextfield: UITextField!
    @IBOutlet weak var surnamePlaceholder: UILabel!
    
    @IBOutlet weak var surnameErrorView: UIView!
    @IBOutlet weak var surnameErrorCaption: UILabel!
    
    //MARK: Phone Outlets
    @IBOutlet weak var phoneTextfieldWrapper: UIView!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var phonePlaceholder: UILabel!
    
    @IBOutlet weak var phoneErrorViewWrapper: UIView!
    @IBOutlet weak var phoneErrorCaption: UILabel!
    
    //MARK: Email Outlets
    @IBOutlet weak var emailTextfieldWrapper: UIView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailPlaceholder: UILabel!
    
    @IBOutlet weak var emailErrorView: UIView!
    @IBOutlet weak var emailErrorCaption: UILabel!
    
    //MARK: PasswordView Outlets
    @IBOutlet weak var setPasswordTitle: UILabel!
    @IBOutlet weak var setPasswordDescription: UILabel!
    
    //MARK: Password Outlets
    @IBOutlet weak var passwordTextfieldWrapper: UIView!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordTextfieldImage: UIImageView!
    @IBOutlet weak var passwordPlaceholder: UILabel!
    
    @IBOutlet weak var passwordErrorView: UIView!
    @IBOutlet weak var passwordErrorCaption: UILabel!
    
    //MARK: SignUp Button Outlets
    @IBOutlet weak var signUpButtonWrapper: UIView!
    @IBOutlet weak var signUpCaption: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    //MARK: TextFields Logic
    var isPasswordHidden = false {
        didSet {
            self.passwordTextfield.isSecureTextEntry = isPasswordHidden
            let imageName = isPasswordHidden ? "eye.slash" : "eye"
            self.passwordTextfieldImage.image = UIImage(systemName: imageName)
        }
    }
    
    var isUsernameValid: Bool = false
    var isSurnameValid: Bool = false
    var isPhoneValid: Bool = false
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false
    
    var type: TextFieldType = .username
    
    var presenter: SignUpScreenPresenter!
    
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
        self.isPasswordHidden = true
        self.backButtonViewWrapper.roundAllCorners(cornerRadius: 25)
        self.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        
        let viewsArray: [UIView] = [self.usernameTextFieldWrapper, self.surnameTextfieldWrapper, self.phoneTextfieldWrapper, self.emailTextfieldWrapper,
            self.passwordTextfieldWrapper]
        
        self.applyBorders(views: viewsArray)
        self.roundCorner(views: viewsArray)
        self.setupLabels()
        self.configureTextFields()
    }
    
    func applyBorders(views: [UIView]) {
        views.forEach { view in
            view.layer.borderColor = UIColor.etSoftGrayGreen.cgColor
            view.layer.borderWidth = 1
        }
    }
    
    func roundCorner(views: [UIView]) {
        views.forEach { eachView in
            eachView.roundAllCorners(cornerRadius: 18)
        }
        
        self.signUpButtonWrapper.roundAllCorners(cornerRadius: 18)
    }
    
    func setupLabels() {
        self.setupFonts(labels: [self.enterDetailsDescription, self.usernamePlaceholder, self.surnamePlaceholder, self.phonePlaceholder, self.emailPlaceholder,
            self.setPasswordDescription, self.passwordPlaceholder])
        self.setupInstructionLabels(titles: [self.enterDetailsTitle, self.setPasswordTitle])
        
        self.signUpTitleCaption.font = UIFont(name: "Lato-Black", size: 36)
        self.signUpDescriptionCaption.font = UIFont(name: "Lato-Regular", size: 20)
        self.signUpCaption.font = UIFont(name: "Lato-Bold", size: 17)
        
        self.signUpTitleCaption.text = String(localized: "SIGNUP_SCREEN_WELCOME_TEXT")
        self.signUpDescriptionCaption.text = String(localized: "SIGNUP_SCREEN_WELCOME_DESCRIPTION")
        
        self.enterDetailsTitle.text = String(localized: "DETAILS_INSTRUCTIONS_TITLE")
        self.enterDetailsDescription.text = String(localized: "DETAILS_INSTRUCTIONS_DESCRIPTION")
        
        self.usernamePlaceholder.text = String(localized: "TEXTFIELD_USERNAME_PLACEHOLDER")
        self.surnamePlaceholder.text = String(localized: "TEXTFIELD_SURNAME_PLACEHOLDER")
        self.phonePlaceholder.text = String(localized: "TEXTFIELD_PHONE_PLACEHOLDER")
        self.emailPlaceholder.text = String(localized: "TEXTFIELD_EMAIL_PLACEHOLDER")
        
        
        self.setPasswordTitle.text = String(localized: "PASSWORD_INSTRUCTIONS_TITLE")
        self.setPasswordDescription.text = String(localized: "PASSWORD_INSTRUCTIONS_DESCRIPTION")
        self.passwordPlaceholder.text = String(localized: "TEXTFIELD_PASSWORD_PLACEHOLDER")
        
        self.signUpCaption.text = String(localized: "SIGNUP_BUTTON_CAPTION")
        
    }
    
    func setupFonts(labels: [UILabel]) {
        labels.forEach { label in
            label.font = UIFont(name: "Lato-Regular", size: 17)
        }
    }
    
    func setupInstructionLabels(titles: [UILabel]) {
        titles.forEach { title in
            title.font = UIFont(name: "Lato-Bold", size: 24)
        }
    }
    
    func configureTextFields() {
        
        let textFieldsArray: [UITextField] = [self.usernameTextfield, self.surnameTextfield, self.phoneTextfield, self.emailTextfield, self.passwordTextfield]
        self.setupTextFields(textFields: textFieldsArray)
        
        passwordTextfieldImage.isUserInteractionEnabled = true
        passwordTextfieldImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePassword)))
        self.dismissKeyboardWhenTappedAround()

        textFieldsArray.forEach { textField in
            textField.delegate = self
        }
        
        self.usernameTextfield.tag = TextFieldType.username.rawValue
        self.surnameTextfield.tag = TextFieldType.lastname.rawValue
        self.phoneTextfield.tag = TextFieldType.phone.rawValue
        self.emailTextfield.tag = TextFieldType.email.rawValue
        self.passwordTextfield.tag = TextFieldType.password.rawValue
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
        self.dismiss(animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        print("Tapped Sign Up")
        self.checkTextFields()
    }
}
