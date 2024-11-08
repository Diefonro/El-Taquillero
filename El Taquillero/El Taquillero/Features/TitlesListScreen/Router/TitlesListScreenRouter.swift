//
//  TitlesListScreenRouter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//


import UIKit

class TitlesListScreenRouter {
    
    weak var view: TitlesListScreenVC?
    
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
    
}
