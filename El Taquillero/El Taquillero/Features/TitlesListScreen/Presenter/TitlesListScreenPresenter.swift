//
//  TitlesListScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//


import UIKit

protocol TItleListScreenPresenterProtocol {
    func viewUIReady()
}

class TitlesListScreenPresenter {
    var view: TitlesListScreenVC
    var interactor: HomeScreenInteractor
    var router: TitlesListScreenRouter
    
    init(view: TitlesListScreenVC, interactor: HomeScreenInteractor, router: TitlesListScreenRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewUIReady() {
    }
}
