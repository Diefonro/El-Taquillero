//
//  LoginScreenVC+Extension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 09/11/2024.
//

import UIKit

//MARK: TextFields Logic

extension LoginScreenVC {
    
    func checkTextFields() {
        // Clear previous error messages and hide error labels
        usernameErrorLabel.text = ""
        passwordErrorLabel.text = ""
        usernameErrorView.isHidden = true
        passwordErrorView.isHidden = true
        
        // Validate username
        validateTextField(textField: usernameTextField,
                          errorLabel: usernameErrorLabel,
                          errorView: usernameErrorView,
                          validation: { text in
            return text.isEmpty ? String(localized: "TEXTFIELD_EMAIL_EMPTY") : (text.validateAsEmail() ? nil : String(localized: "TEXTFIELD_EMAIL_INVALID"))
        })
        
        // Validate password
        validateTextField(textField: passwordTextField,
                          errorLabel: passwordErrorLabel,
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
            self.applyBorders(views: [self.usernameTextFieldWrapper, self.passwordTextFieldWrapper])
            self.setupTextFields(textFields: [self.passwordTextField, self.usernameTextField])
            
            let email = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            
            print("Form is valid")
            print("Username: \(email)")
            print("Password: \(password)")
            
            FirebaseGlobalFunctions.loginUser(email: email, password: password) { result in
                switch result {
                case .success(let message):
                    print(message)
                    self.onLoginSucceed?()
                    self.dismiss(animated: true)
                case .failure(let error):
                    let errorLocalized = error.localizedDescription
                    print("Error during registration: \(errorLocalized)")
                    if errorLocalized == "The supplied auth credential is malformed or has expired." {
                        self.passwordErrorView.isHidden = false
                        self.passwordErrorLabel.text = String(localized: "LOGIN_REQUEST_ERROR")
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

extension LoginScreenVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.scrollRectToVisible(textField.frame, animated: true)
        
        guard let textFieldType = TextFieldType(rawValue: textField.tag) else { return }
        
        let placeholder: UILabel?
        
        switch textFieldType {
        case .email:
            placeholder = self.usernamePlaceholder
        case .password:
            placeholder = self.passwordPlaceholder
        default:
            placeholder = nil
        }
        
        if let placeholder = placeholder {
            UIView.animate(withDuration: 0.125) {
                placeholder.frame.origin.y = -10
                placeholder.frame.origin.x = 45
            }
            placeholder.backgroundColor = .etWhite
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldType = TextFieldType(rawValue: textField.tag) else { return }
        
        let placeholder: UILabel?
        
        switch textFieldType {
        case .email:
            placeholder = self.usernamePlaceholder
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
                placeholder.frame.origin.x = 80
            }
            placeholder.backgroundColor = .clear
        }
    }
}


