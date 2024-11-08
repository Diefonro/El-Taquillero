//
//  HomeScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

protocol HomeScreenRouterProtocol {
    func navigateToTitleDetail(context: Results, title: String)
    func navigateToTitleList(context: [Results], title: String, contentType: ContentType, language: String)
}

class HomeScreenRouter: HomeScreenRouterProtocol{
    
    weak var view: HomeScreenVC?
    
    func navigateToTitleDetail(context: Results, title: String) {
        if let titleDetailVC = UIStoryboard(name: TitleDetailScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: TitleDetailScreenVC.identifier) as? TitleDetailScreenVC {
            titleDetailVC.context = context
            titleDetailVC.titleName = title
            titleDetailVC.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.view?.navigationController?.navigationBar.isHidden = false
            self.view?.navigationController?.pushViewController(titleDetailVC, animated: true)
        }
    }
    
    func navigateToTitleList(context: [Results], title: String, contentType: ContentType, language: String) {
        if let titleListVC = UIStoryboard(name: TitlesListScreenVC.storyboard, bundle: nil).instantiateViewController(withIdentifier: TitlesListScreenVC.identifier) as? TitlesListScreenVC {
            
            let interactor = HomeScreenInteractor()
            let router = TitlesListScreenRouter()
            router.view = titleListVC
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
