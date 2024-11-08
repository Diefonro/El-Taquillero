//
//  TitleTableCell.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class TitleTableCell: UITableViewCell, CellInfo {
    
    static var reuseIdentifier = "TitleTableCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleReleaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        self.containerView.roundAllCorners(cornerRadius: 18)
        
        self.titleNameLabel.font = UIFont(name: "Lato-Bold", size: 40)
        self.titleReleaseDateLabel.font = UIFont(name: "Lato-Regular", size: 17)
    }
    
    func setupCell(with context: Results) {
        let imagePath = context.getPosterPath()
        let imageURL = HomeConstants.imageURL + imagePath
        self.posterImageView.setURLImage(imageUrl: imageURL)
        
        self.titleNameLabel.text = context.title ?? context.name
        
        let dateString = context.releaseDate ?? context.firstAirDate
        if let date = dateString?.toDate() ?? context.firstAirDate?.toDate(){
            self.titleReleaseDateLabel.text = "\(String(localized: "TITLE_LIST_SCREEN_RELEASE_DATE_CAPTION")) \(date.formattedPublishedDate())"
        }
    }
    
}
