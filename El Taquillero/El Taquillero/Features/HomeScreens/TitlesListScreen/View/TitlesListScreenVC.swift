//
//  TitlesListScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

enum ContentType {
    case topMovies
    case topSeries
}

class TitlesListScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "TitlesListScreen"
    static var identifier = "TitlesListScreenVC"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TitlesListScreenPresenter!
    var contentType: ContentType = .topMovies
    var context: [Results] = []
    
    var isLoading = false
    var currentPage = 1
    var language = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .etWhite
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.etPorcelain]

    }
    
    func setupTableView() {
        self.tableView.backgroundColor = .clear
        self.tableView.register(UINib(nibName: TitleTableCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TitleTableCell.reuseIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func loadData(forPage page: Int) {
        isLoading = true
        
        if self.contentType == .topMovies {
            presenter.interactor.fetchTopMovies(completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.context.append(contentsOf: data.getTitles())
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
                self.isLoading = false
            }, language: self.language, page: "\(page)")
        } else {
            presenter.interactor.fetchTopSeries(completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.context.append(contentsOf: data.getTitles())
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
                self.isLoading = false
            }, language: self.language, page: "\(page)")
        }
        
    }
    
    func loadNextPage() {
        currentPage += 1
        loadData(forPage: currentPage)
    }
}

extension TitlesListScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.context.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableCell.reuseIdentifier, for: indexPath) as? TitleTableCell {
            let result = self.context[indexPath.row]
            cell.setupCell(with: result)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let context = self.context[indexPath.row]
        if let title = context.title ?? context.name {
            self.presenter.readyToNavigateToDetail(context: context, title: title)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLoading {
            return
        }
        
        let contentHeight = scrollView.contentSize.height
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 {
            loadNextPage()
        }
    }
}
