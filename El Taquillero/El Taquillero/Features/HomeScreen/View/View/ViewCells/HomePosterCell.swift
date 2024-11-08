//
//  HomePosterCell.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol HomePosterCellProtocol: AnyObject {
    func setupCell(with context: Results)
    func setupUI()
}
class HomePosterCell: UICollectionViewCell, CellInfo, HomePosterCellProtocol {
    
    static var reuseIdentifier = "HomePosterCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleGenreLabel: UILabel!
    
    
    @IBOutlet weak var gradientView: UIView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.gradientView.applyDarkGradient()
        }
    }
    
    func setupUI() {
        setupLabels()
        
    }
    
    func setupLabels() {
        self.titleNameLabel.font = UIFont(name: "Lato-BlackItalic", size: 42)
        self.titleGenreLabel.font = UIFont(name: "Lato-Bold", size: 18)
        setupLabelsColor(labels: [titleNameLabel, titleGenreLabel])
    }
    
    func setupLabelsColor(labels: [UILabel]) {
        for eachLabel in labels {
            eachLabel.textColor = .etPorcelain
        }
    }
    
    func setupCell(with context: Results) {
        let imagePath = context.getPosterPath()
        let imageURL = HomeConstants.imageURL + imagePath
        self.posterImageView.setURLImage(imageUrl: imageURL)
        
        self.titleNameLabel.text = context.title ?? context.name
        
        let genreIDS = context.getGenres()
        let genreDictionary = HomeConstants.genreDictionary
        let genreNames = genreIDS.compactMap { genreDictionary[$0] }
        let genreLabelText = genreNames.joined(separator: ", ")
        
        self.titleGenreLabel.text = genreLabelText
    }
    
    
}
