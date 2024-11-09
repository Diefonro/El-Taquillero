//
//  TitleDetailScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class TitleDetailScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "TitleDetailScreen"
    static var identifier = "TitleDetailScreenVC"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var simulatedNavBarView: UIView!
    @IBOutlet weak var simulatedNavLabel: UILabel!
    
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    @IBOutlet weak var posterImageView: UIView!
    @IBOutlet weak var posterUIImageView: UIImageView!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleInfoLabel: UILabel!
    
    @IBOutlet weak var reproduceButtonView: UIView!
    @IBOutlet weak var reproduceButtonLabel: UILabel!
    @IBOutlet weak var reproduceButton: UIButton!
    
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    var context: Results?
    var titleName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.simulatedNavBarView.setupCustomNavBar(navBar: self.simulatedNavBarView, label: self.simulatedNavLabel, context: self, rootScreen: .sliders)
        self.setupImageView(context: self.context!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.gradientView.applyDarkGradient()
    }
    
    func setupUI() {
        self.simulatedNavBarView.alpha = 0
        self.scrollView.delegate = self
        setupLabels()
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupLabels() {
        self.titleNameLabel.font = UIFont(name: "Lato-BlackItalic", size: 42)
        self.titleNameLabel.textColor = .etPorcelain
        
        self.titleInfoLabel.font = UIFont(name: "Lato-Bold", size: 14)
        self.titleInfoLabel.textColor = .etLightPaleGray
        
        self.reproduceButtonLabel.font = UIFont(name: "Lato-Bold", size: 16)
        self.reproduceButtonLabel.textColor = .etDarkTeal
    }
    
    
    func setupImageView(context: Results) {
        self.simulatedNavLabel.text = self.titleName
        
        let imagePath = context.getPosterPath()
        let imageURL = HomeConstants.imageURL + imagePath
        self.posterUIImageView.setURLImage(imageUrl: imageURL)
        
        self.titleNameLabel.text = context.title ?? context.name
        
        self.setupTitleInfo(context: context)
        
        self.reproduceButtonView.roundAllCorners(cornerRadius: 8)
        self.reproduceButtonLabel.text = String(localized: "TITLE_DETAIL_REPRODUCE_BUTTON_CAPTION")
        
        self.titleDescriptionLabel.text = context.getDescription()
        
    }
    
    func setupTitleInfo(context: Results) {
        
        let genreIDS = context.getGenres()
        let genreDictionary = HomeConstants.genreDictionary
        let genreNames = genreIDS.compactMap { genreDictionary[$0] }
        let genreLabelText = genreNames.joined(separator: ", ")
        
        let genres = genreLabelText
        
        var dateText: String = ""
        let dateString = context.releaseDate ?? context.firstAirDate
        if let date = dateString?.toDate() ?? context.firstAirDate?.toDate(){
            dateText = "\(String(localized: "TITLE_LIST_SCREEN_RELEASE_DATE_CAPTION")) \(date.formattedPublishedDate())"
        }
        
        let rating = context.getRating()
        let ratingText = "⭐️ \(rating)"
        
        let titleComponents = [genres, dateText, ratingText]
        let titleText = titleComponents.joined(separator: " • ")
        
        self.titleInfoLabel.text = titleText
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reproduceButtonAction(_ sender: Any) {
        print("Reproduce title")
    }
    
}

extension TitleDetailScreenVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let navigationBarAlpha = min(1, offsetY / 100)
        simulatedNavBarView.alpha = navigationBarAlpha
    }
}
