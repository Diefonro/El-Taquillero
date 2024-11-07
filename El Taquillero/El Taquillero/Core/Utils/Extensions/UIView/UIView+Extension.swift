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
    
    
}


