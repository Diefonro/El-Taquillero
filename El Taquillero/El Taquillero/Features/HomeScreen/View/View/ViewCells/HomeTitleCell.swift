//
//  HomeTitleCell.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

class HomeTitleCell: UICollectionViewCell, CellInfo {
    
    static var reuseIdentifier = "HomeTitleCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        self.imageViewContainer.roundAllCorners(cornerRadius: 18)
        self.titleNameLabel.font = UIFont(name: "Lato-Bold", size: 18)
        self.titleNameLabel.textColor = .etPorcelain
    }
    
    func setupCell(with context: Results) {
        let imagePath = context.getPosterPath()
        let imageURL = HomeConstants.imageURL + imagePath
        self.titleImageView.setURLImage(imageUrl: imageURL)
        
        self.titleNameLabel.text = context.title ?? context.name
    }

}
