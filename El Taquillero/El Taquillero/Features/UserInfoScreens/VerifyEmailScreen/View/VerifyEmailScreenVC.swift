//
//  VerifyEmailScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class VerifyEmailScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "VerifyEmailScreen"
    static var identifier = "VerifyEmailScreenVC"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var verifyEmailTitle: UILabel!
    @IBOutlet weak var verifyEmailDescription: UILabel!
    
    @IBOutlet weak var verifyErrorView: UIView!
    @IBOutlet weak var verifyErrorCaption: UILabel!
    
    @IBOutlet weak var verifyButtonWrapper: UIView!
    @IBOutlet weak var verifyButtonCaption: UILabel!
    
    var onEmailVerified: (() -> Void)?
    
    var userMail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.verifyButtonWrapper.roundAllCorners(cornerRadius: 18)
        self.containerView.roundTopCorners(cornerRadius: 25)
        setupLabels()
    }
    
    func setupLabels() {
        self.verifyEmailTitle.text = String(localized: "VERIFY_EMAIL_TITLE")
        self.verifyEmailTitle.font = UIFont(name: "Lato-Black", size: 24)
        self.verifyEmailDescription.text = "\(String(localized: "VERIFY_EMAIL_DESCRIPTION")) '\(self.userMail)'"
        self.verifyEmailDescription.font = UIFont(name: "Lato-Regular", size: 18)
        self.verifyButtonCaption.text = String(localized: "VERIFY_BUTTON_CAPTION")
        self.verifyButtonCaption.font = UIFont(name: "Lato-Bold", size: 17)
        
    }
    
    func checkIfVerified() {
        FirebaseGlobalFunctions.checkEmailVerification { isVerified in
            if isVerified {
                print("Email is verified!")
                self.dismiss(animated: true)
                self.onEmailVerified?()
            } else {
                print("Email is not verified.")
                self.verifyErrorView.isHidden = false
                self.verifyErrorCaption.text = String(localized: "VERIFY_ERROR_CAPTION")
            }
        }
    }
    
    @IBAction func verifyButtonAction(_ sender: Any) {
        self.checkIfVerified()
        print("Tapped verify button.")
    }
}
