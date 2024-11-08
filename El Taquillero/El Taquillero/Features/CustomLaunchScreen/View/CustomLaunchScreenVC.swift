//
//  CustomLaunchScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol CustomLaunchScreenViewProtocol {
    func setupUI()
}

class CustomLaunchScreenVC: UIViewController,  CustomLaunchScreenViewProtocol, StoryboardInfo {
    
    static var storyboard = "CustomLaunchScreen"
    static var identifier = "CustomLaunchScreenVC"
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var presenter: CustomLaunchScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVIPER()
    }
    
    func setupVIPER() {
        let presenter = CustomLaunchScreenPresenter()
        let router = CustomLaunchScreenRouter()
        presenter.router = router
        presenter.view = self
        router.view = self
        self.presenter = presenter
    }

    func setupUI() {
        self.iconImageView.image = UIImage(named: "ETAppIcon")
        
        UIView.animate(withDuration: 3.0) {
            self.iconImageView.alpha = 1
            self.iconImageView.showScaleEffectAnimated()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.presenter?.viewUIReady()
        }
    }
    
}
