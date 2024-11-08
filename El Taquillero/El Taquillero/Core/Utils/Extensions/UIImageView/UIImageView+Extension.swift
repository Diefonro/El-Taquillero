//
//  UIImageView+Extension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

extension UIImageView {
    
    func showScaleEffectAnimated() {
        UIView.animate(withDuration: 3.0, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: nil)
    }
    
    func setURLImage(imageUrl: String, placeholder: UIImage? = UIImage(named: "ETPlaceholderImage")) {
        self.image = placeholder
        
        guard let url = URL(string: imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, error == nil, let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            } else {
                print("Failed to load image from URL:", error ?? "Unknown error")
            }
        }.resume()
    }
    
}

