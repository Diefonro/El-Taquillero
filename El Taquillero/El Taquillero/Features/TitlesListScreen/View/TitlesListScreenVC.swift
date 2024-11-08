//
//  TitlesListScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class TitlesListScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "TitlesListScreen"
    static var identifier = "TitlesListScreenVC"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TitlesListScreenPresenter!
    
    var context: [Results] = []
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
