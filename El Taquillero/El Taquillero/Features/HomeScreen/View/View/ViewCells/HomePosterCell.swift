//
//  HomePosterCell.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol HomePosterCellProtocol: AnyObject {
    func setupCell(with title: Titles)
    func setupUI()
}
class HomePosterCell: UICollectionViewCell, CellInfo, HomePosterCellProtocol {
    
    static var reuseIdentifier = "HomePosterCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleGenreLabel: UILabel!
    
    @IBOutlet weak var testView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.testView.applyDarkGradient()
        }
        
    }
    
    func setupUI() {
        setupLabels()
        
    }
    
    func setupLabels() {
        self.titleNameLabel.font = UIFont(name: "Lato-BlackItalic", size: 80)
        self.titleGenreLabel.font = UIFont(name: "Lato-Bold", size: 20)
        setupLabelsColor(labels: [titleNameLabel, titleGenreLabel])
    }
    
    func setupLabelsColor(labels: [UILabel]) {
        for eachLabel in labels {
            eachLabel.textColor = .etPorcelain
        }
    }
    
    func setupCell(with title: Titles) {
        self.posterImageView.setURLImage(imageUrl: title.titleImageURL!)
        self.titleNameLabel.text = title.titleName
        self.titleGenreLabel.text = title.titleGenre
    }
    
}
