//
//  UIView+Extension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

extension UIView {
    func applyDarkGradient() {
        
        if let existingGradientLayer = (self.layer.sublayers ?? []).first(where: { $0 is CAGradientLayer }) {
            existingGradientLayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func roundAllCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func roundTopCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupCustomNavBar(navBar: UIView, label: UILabel, context: UIViewController, rootScreen: RootScreen) {
        navBar.backgroundColor = .etLightTeal
        navBar.addBottomBorder(with: .darkGray, andWidth: 0.5)
        label.font = UIFont(name: "Lato-Bold", size: 18)
        label.textColor = .etPorcelain
        
        switch rootScreen {
        case .home:
            label.text = HomeStrings.homeScreenCaption
        case .sliders:
            label.text = ""
        }
        
        context.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        navBar.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: navBar.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: navBar.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: navBar.widthAnchor)
        ])
    }
    
}


