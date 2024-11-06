//
//  LaunchScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

class LaunchScreenVC: UIViewController {

    @IBOutlet weak var launchLabel: UILabel!
    @IBOutlet weak var launchWithLato: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showScaleEffectAnimated()
        self.launchWithLato.font = UIFont(name: "Lato-Bold", size: 17)
    }
    
    private func showScaleEffectAnimated() {
        UIView.animate(withDuration: 3.0, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.launchLabel.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: nil)
    }
}
