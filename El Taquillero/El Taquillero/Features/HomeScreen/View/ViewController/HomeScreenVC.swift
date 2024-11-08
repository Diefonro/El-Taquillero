//
//  HomeScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

class HomeScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "HomeScreen"
    static var identifier = "HomeScreenVC"
    
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var simulatedNavBarView: UIView!
    @IBOutlet weak var simulatedNavBarLabel: UILabel!
    
    var collectionView: UICollectionView = {
        let layout = LayoutType.homePosters.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(PageControlFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.backgroundColor = .etDarkTeal
        return collectionView
    }()
    var footerView = PageControlFooterView()
    
    var presenter: HomeScreenPresenter!
    var titles: [Results] = []
    var topMovies: [Results] = []
    var topSeries: [Results] = []
    
    var isAnyFetchFailed = false
    var isLoading = false
    var language = ""
    var currentPage = 1
    var page = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewContainer.isHidden = true
        self.simulatedNavBarView.alpha = 0
        self.setupCollectionView()
        self.fetchTrendingMovies()
        self.fetchTopMovies()
        self.fetchTopSeries()
        
        let languageCode = LanguageCode()
        self.language = languageCode.getLanguageCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.simulatedNavBarView.setupCustomNavBar(navBar: self.simulatedNavBarView, label: self.simulatedNavBarLabel, context: self)
        self.navigationController?.navigationBar.isHidden = true
    }
 
    func setupCollectionView() {
        collectionView.frame = collectionViewContainer.bounds
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(UINib(nibName: HomePosterCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomePosterCell.reuseIdentifier)
        collectionView.register(UINib(nibName: HomeTitleCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomeTitleCell.reuseIdentifier)
        
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
    
    func updateViewWithTrendingData(with titles: [Results]) {
        self.titles = titles
    }
    
    func updateViewWithTopMoviesData(with topMovies: [Results]) {
        self.topMovies = topMovies
    }
    
    func updateViewWithTopSeriesData(with topSeries: [Results]) {
        self.topSeries = topSeries
    }
    
    func fetchTrendingMovies() {
        presenter.fetchData(for: .trendingMovies, success: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionViewContainer.isHidden = false
            }
        }, failure: {
            DispatchQueue.main.async {
                self.updateViewNoData()
            }
        }, language: self.language, page: self.page)
    }
    
    func fetchTopMovies() {
        presenter.fetchData(for: .topMovies, success: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionViewContainer.isHidden = false
            }
        }, failure: {
            DispatchQueue.main.async {
                self.updateViewNoData()
            }
        }, language: self.language, page: self.page)
    }
    
    func fetchTopSeries() {
        presenter.fetchData(for: .topSeries, success: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionViewContainer.isHidden = false
            }
        }, failure: {
            DispatchQueue.main.async {
                self.updateViewNoData()
            }
        }, language: self.language, page: self.page)
    }

    func updateViewNoData() {
        print("No data :(")
    }
}

