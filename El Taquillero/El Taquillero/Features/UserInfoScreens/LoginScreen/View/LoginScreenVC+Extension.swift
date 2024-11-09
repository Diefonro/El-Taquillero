//
//  LoginScreenVC+Extension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 09/11/2024.
//

import UIKit

extension LoginScreenVC {
    
    func setInvalidTextField(view: UIView, textField: UITextField, showError: Bool = true) {
        if userDidInteract {
            self.invalidTextBorderColor(view: view, textField: textField)
        }
    }
    
    func invalidTextBorderColor(view: UIView, textField: UITextField, showError: Bool = true) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.etRed.cgColor
        textField.textColor = .etRed
    }
    
    private func invalidateTextFieldOfType(_ type: TextFieldType) {
        switch type {
        case .email:
            self.setInvalidTextField(view: self.usernameTextFieldWrapper, textField: self.usernameTextField)
        case .password:
            self.setInvalidTextField(view: self.passwordTextFieldWrapper, textField: self.passwordTextField)
        default:
            break
        }
    }
    
    func validateEnteredData(text: String, textFieldType: TextFieldType, completionHandler: @escaping (Bool) -> Void) {
        switch textFieldType {
        case .email:
            isUsernameValid = !text.isEmpty && text.validateAsEmail()
            completionHandler(isUsernameValid)
        case .password:
            isPasswordValid = !text.isEmpty && text.validateMinimunEightCharactersRequirement() && text.validateMinimunOneNumberRequirement()
            completionHandler(isPasswordValid)
        default:
            completionHandler(false)
        }
    }
    
    private func loginButton(enable: Bool) {
        UIButton.animate(withDuration: 0.25) {
            self.submitButtonWrapper.backgroundColor = enable ? .etDarkTeal : .etMutedGreen
            self.submitButton.isEnabled = enable
        }
    }
    
    private func updateTextFieldsData(text: String, type: TextFieldType) {
        self.validateEnteredData(text: text, textFieldType: type) { isValid in
            if !isValid { self.invalidateTextFieldOfType(type) }
        }
        loginButton(enable: self.isEnteredDataValid)
    }
    
    func manageOnEndEditingEvents() {
        self.onEndEditing = { [weak self] in
            self?.updateTextFieldsData(text: self?.usernameTextField.text ?? "", type: self?.type ?? .email)
        }
        
        self.onEndEditing = { [weak self] in
            self?.updateTextFieldsData(text: self?.passwordTextField.text ?? "", type: self?.type ?? .password)
        }
    }
}

extension LoginScreenVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.userDidInteract = true
        
       
        
        let placeholders : [UILabel] = [self.usernamePlaceholder, self.passwordPlaceholder]
        
        placeholders.forEach { placeholder in
            UIView.animate(withDuration: 0.125) {
                placeholder.frame.origin.y = -0.5
            }
            placeholder.backgroundColor = .etWhite
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
       
        
        let placeholders : [UILabel] = [self.usernamePlaceholder, self.passwordPlaceholder]
        
        
            placeholders.forEach { placeholder in
                UIView.animate(withDuration: 0.125) {
                guard let text = textField.text, text.isEmpty else {
                    placeholder.frame.origin.y = -self.mtop
                    return
                }
                placeholder.frame.origin.y = 23
                placeholder.frame.origin.x = 80
            }
                placeholder.backgroundColor = .clear
        }
        
        if let completion = self.onEndEditing {
            completion()
        }
    }
    
}


