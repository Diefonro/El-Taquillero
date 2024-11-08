//
//  HomeScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

protocol HomeScreenRouterProtocol {
    func navigateToTitleDetail()
    func navigateToTitleList(context: [Results], title: String, contentType: ContentType, language: String)
}

class HomeScreenRouter: HomeScreenRouterProtocol{
    
    weak var view: HomeScreenVC?
    
    func navigateToTitleDetail() {
        
    }
    
    func navigateToTitleList(context: [Results], title: String, contentType: ContentType, language: String) {
        if let titleListVC = UIStoryboard(name: TitlesListScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: TitlesListScreenVC.identifier) as? TitlesListScreenVC {
            
            let interactor = HomeScreenInteractor()
            let router = TitlesListScreenRouter()
            let presenter = TitlesListScreenPresenter(view: titleListVC, interactor: interactor, router: router)
            titleListVC.presenter = presenter
            
            titleListVC.title = title
            titleListVC.context = context
            titleListVC.hidesBottomBarWhenPushed = true
            
            titleListVC.contentType = contentType
            titleListVC.language = language
            
            self.view?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.view?.navigationController?.navigationBar.isHidden = false
            self.view?.navigationController?.pushViewController(titleListVC, animated: true)
        }
    }
}
