//
//  SignUpScreen+Extension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

extension SignUpScreenVC {
    
    func checkTextFields() {
        // Clear previous error messages and hide error labels
        usernameErrorCaption.text = ""
        surnameErrorCaption.text = ""
        phoneErrorCaption.text = ""
        emailErrorCaption.text = ""
        passwordErrorCaption.text = ""
        
//        usernameErrorView.isHidden = true
//        surnameErrorView.isHidden = true
//        phoneErrorViewWrapper.isHidden = true
//        emailErrorView.isHidden = true
//        passwordErrorView.isHidden = true
        
        // Validate username
        validateTextField(textField: usernameTextfield,
                          errorLabel: usernameErrorCaption,
                          errorView: usernameErrorView,
                          validation: { text in
            return text.isEmpty ? String(localized: "TEXTFIELD_USERNAME_EMPTY") : (text.validateAlphabeticRequirement() ? nil : String(localized: "TEXTFIELD_USERNAME_INVALID"))
        })
        
        // Validate surname
        validateTextField(textField: surnameTextfield, errorLabel: surnameErrorCaption, errorView: surnameErrorView) { text in
            return text.isEmpty ? String(localized: "TEXTFIELD_SURNAME_EMPTY") : (text.validateAlphabeticRequirement() ? nil : String(localized: "TEXTFIELD_SURNAME_INVALID"))
        }
        
        // Validate phone
        validateTextField(textField: phoneTextfield, errorLabel: phoneErrorCaption, errorView: phoneErrorViewWrapper) { text in
            return text.isEmpty ? String(localized: "TEXTFIELD_PHONE_EMPTY") : (text.validateNumericRequirement() ? nil : String(localized: "TEXTFIELD_PHONE_INVALID"))
        }
        
        // Validate email
        validateTextField(textField: emailTextfield,
                          errorLabel: emailErrorCaption,
                          errorView: emailErrorView,
                          validation: { text in
            return text.isEmpty ? String(localized: "TEXTFIELD_EMAIL_EMPTY") : (text.validateAsEmail() ? nil : String(localized: "TEXTFIELD_EMAIL_INVALID"))
        })
        
        // Validate password
        validateTextField(textField: passwordTextfield,
                          errorLabel: passwordErrorCaption,
                          errorView: passwordErrorView,
                          validation: { text in
            switch true {
            case text.isEmpty: return String(localized: "TEXTFIELD_PASSWORD_EMPTY")
            case !text.validateMinimunEightCharactersRequirement(): return String(localized: "TEXTFIELD_PASSWORD_SHORT")
            case !text.validateMinimunOneNumberRequirement(): return String(localized: "TEXTFIELD_PASSWORD_MISSING_NUMBER")
            case !text.validateSpecialCharacterRequirement(): return String(localized: "TEXTFIELD_PASSWORD_MISSING_SPECIAL_CHARACTER")
            case !text.validateUppercaseLetterRequirement(): return String(localized: "TEXTFIELD_PASSWORD_MISSING_UPPERCASE")
            case !text.validateLowercaseLetterRequirement(): return String(localized: "TEXTFIELD_PASSWORD_MISSING_LOWERCASE")
            default: return nil
            }
        })
        
        // If there are no errors, print form data
        if usernameErrorView.isHidden && passwordErrorView.isHidden {
            
            let viewsArray: [UIView] = [self.usernameTextFieldWrapper, self.surnameTextfieldWrapper, self.phoneTextfieldWrapper, self.emailTextfieldWrapper,
                self.passwordTextfieldWrapper]
            self.applyBorders(views: viewsArray)
            
            let textFieldsArray: [UITextField] = [self.usernameTextfield, self.surnameTextfield, self.phoneTextfield, self.emailTextfield, self.passwordTextfield]
            self.setupTextFields(textFields: textFieldsArray)
            
            let name = usernameTextfield.text ?? ""
            let surname = surnameTextfield.text ?? ""
            let phone = phoneTextfield.text ?? ""
            let email = emailTextfield.text ?? ""
            let password = passwordTextfield.text ?? ""
            
            print("Form is valid")
            print("Username: \(name)")
            print("Surname: \(surname)")
            print("Phone: \(phone)")
            print("Email: \(email)")
            print("Password: \(password)")
            
            
            
            FirebaseGlobalFunctions.signUpUser(name: name, surname: surname, phone: phone, email: email, password: password) { result in
                switch result {
                case .success(let message):
                    print(message)
                    
                    FirebaseGlobalFunctions.sendVerificationEmail { verificationResult in
                        switch verificationResult {
                        case .success(let successMessage):
                            print(successMessage)
                            if let email = SessionCRUDFunctions.shared.fetchEmail() {
                                self.presenter.readyToPopUpVerifyScreen(userMail: email)
                            } else {
                                print("Email to verify not found.")
                            }
                        case .failure(let error):
                            print("Failed to send verification email: \(error.localizedDescription)")
                        }
                    }
                    
                case .failure(let error):
                    print("Error during registration: \(error.localizedDescription)")
                    let errorLocalized = error.localizedDescription
                    print("Error during registration: \(errorLocalized)")
                    if errorLocalized == "The email address is already in use by another account." {
                        self.emailErrorView.isHidden = false
                        self.emailErrorCaption.text = String(localized: "EMAIL_ALREADY_IN_USE")
                    } else {
                        print("An unknown error occurred.")
                    }
                    
                }
            }
        }
    }
    
    func validateTextField(textField: UITextField, errorLabel: UILabel, errorView: UIView, validation: (String) -> String?) {
        let text = textField.text ?? ""
        
        if let errorMessage = validation(text) {
            errorLabel.text = errorMessage
            errorView.isHidden = false
        } else {
            errorView.isHidden = true
        }
    }
    
    func invalidTextBorderColor(view: UIView, textField: UITextField) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.etRed.cgColor
        textField.textColor = .etRed
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}

extension SignUpScreenVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.scrollRectToVisible(textField.frame, animated: true)
        
        guard let textFieldType = TextFieldType(rawValue: textField.tag) else { return }
        
        let placeholder: UILabel?
        
        switch textFieldType {
        case .username:
            placeholder = self.usernamePlaceholder
        case .lastname:
            placeholder = self.surnamePlaceholder
        case .phone:
            placeholder = self.phonePlaceholder
        case .email:
            placeholder = self.emailPlaceholder
        case .password:
            placeholder = self.passwordPlaceholder
        default:
            placeholder = nil
        }
        
        if let placeholder = placeholder {
            UIView.animate(withDuration: 0.125) {
                placeholder.frame.origin.y = -10
                placeholder.frame.origin.x = 40
            }
            placeholder.backgroundColor = .etWhite
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldType = TextFieldType(rawValue: textField.tag) else { return }
        
        let placeholder: UILabel?
        
        switch textFieldType {
        case .username:
            placeholder = self.usernamePlaceholder
        case .lastname:
            placeholder = self.surnamePlaceholder
        case .phone:
            placeholder = self.phonePlaceholder
        case .email:
            placeholder = self.emailPlaceholder
        case .password:
            placeholder = self.passwordPlaceholder
        default:
            placeholder = nil
        }
        
        if let placeholder = placeholder {
            UIView.animate(withDuration: 0.125) {
                guard let text = textField.text, text.isEmpty else {
                    placeholder.frame.origin.y = -12
                    return
                }
                placeholder.frame.origin.y = 29
                placeholder.frame.origin.x = 60
            }
            placeholder.backgroundColor = .clear
        }
    }
}

