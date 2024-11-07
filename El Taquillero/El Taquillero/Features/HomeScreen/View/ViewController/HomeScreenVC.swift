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
    
    var collectionView: UICollectionView = {
        let layout = LayoutType.homePosters.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .etWhite
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        setupCollectionView()
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
    
    func setupVIPER() {
        print("on it")
    }
    
}
