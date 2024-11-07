//
//  HomeScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol HomeScreenViewProtocol {
    func setupUI()
    func setupCollectionView()
}

class HomeScreenVC: UIViewController, StoryboardInfo, HomeScreenViewProtocol {
    
    static var storyboard = "HomeScreen"
    static var identifier = "HomeScreenVC"
    
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var simulatedNavBarView: UIView!
    @IBOutlet weak var simulatedNavBarLabel: UILabel!
    
    var collectionView: UICollectionView = {
        let layout = LayoutType.homePosters.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PageControlFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = .etDarkTeal
        return collectionView
    }()
    
    var footerView = PageControlFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCustomNavBar()
    }
    
    func setupUI() {
        setupCollectionView()
        self.simulatedNavBarView.alpha = 0
    }
    
    func setupCollectionView() {
        collectionView.frame = collectionViewContainer.bounds
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(UINib(nibName: HomePosterCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomePosterCell.reuseIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewContainer.addSubview(collectionView)
        // Create and activate constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor)
        ])
        
    }
    
    func setupCustomNavBar() {
        self.simulatedNavBarView.addBottomBorder(with: .darkGray, andWidth: 0.5)
        self.simulatedNavBarLabel.text = HomeStrings.homeScreenCaption
        self.simulatedNavBarLabel.font = UIFont(name: "Lato-Bold", size: 18)
        self.simulatedNavBarLabel.textColor = .etPorcelain
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        simulatedNavBarView.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: simulatedNavBarView.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: simulatedNavBarView.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: simulatedNavBarView.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: simulatedNavBarView.widthAnchor)
        ])
    }
    
    func setupVIPER() {
        print("on it")
    }
    
}

