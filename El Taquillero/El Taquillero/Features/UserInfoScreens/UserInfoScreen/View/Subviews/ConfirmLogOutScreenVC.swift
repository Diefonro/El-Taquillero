//
//  ConfirmLogOutScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit

class ConfirmLogOutScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "ConfirmLogOutScreen"
    static var identifier = "ConfirmLogOutScreenVC"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var logOutTitleCaption: UILabel!
    @IBOutlet weak var logOutDescriptionCaption: UILabel!
    
    @IBOutlet weak var logOutErrorView: UIView!
    @IBOutlet weak var logOutErrorCaption: UILabel!
    
    @IBOutlet weak var cancelButtonCaption: UILabel!
    
    @IBOutlet weak var logOutButtonWrapper: UIView!
    @IBOutlet weak var logOutButtonCaption: UILabel!
    
    var onLogOutConfirmedPressed: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.containerView.roundTopCorners(cornerRadius: 25)
        self.logOutButtonWrapper.roundAllCorners(cornerRadius: 25)
        self.logOutButtonWrapper.backgroundColor = .etRed
        self.setupLabels()
    }
    
    func setupLabels() {
        self.logOutTitleCaption.text = String(localized: "LOG_OUT_TITLE")
        self.logOutTitleCaption.font = UIFont(name: "Lato-Black", size: 24)
        self.logOutDescriptionCaption.text = (String(localized: "LOG_OUT_DESCRIPTION"))
        self.logOutDescriptionCaption.font = UIFont(name: "Lato-Regular", size: 18)
        
        self.cancelButtonCaption.text = String(localized: "CANCEL_BUTTON_CAPTION")
        self.cancelButtonCaption.font = UIFont(name: "Lato-Bold", size: 17)
        self.cancelButtonCaption.textColor = .etDarkTeal
        
        self.logOutButtonCaption.text = String(localized: "LOGOUT_BUTTON_CAPTION")
        self.logOutButtonCaption.font = UIFont(name: "Lato-Bold", size: 17)
        self.logOutButtonCaption.textColor = .etWhite
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        print("cancel")
        self.dismiss(animated: true)
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        self.onLogOutConfirmedPressed?()
        print("log out")
    }
    

}
