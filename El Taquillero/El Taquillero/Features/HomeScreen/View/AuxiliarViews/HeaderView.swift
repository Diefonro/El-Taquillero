//
//  HeaderView.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Lato-Bold", size: 20)
        label.textColor = .etLightPaleGray
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "HOME_VIEW_ALL_BUTTON_CAPTION"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.etLightPaleGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: 22)
        return button
    }()
    
    var didTapOnViewAll: ((_ navTitle: String) -> Void)?
    var navTitle: String? = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(label)
        addSubview(button)
        
        label.frame = CGRect(x: 10, y: 0, width: frame.size.width - 110, height: 35)
        button.frame = CGRect(x: frame.size.width - 90, y: 0, width: 90, height: 35)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        self.didTapOnViewAll?(navTitle!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

