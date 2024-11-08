//
//  HomeScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

protocol HomeScreenPresenterProtocol {
    func fetchData(success: @escaping () -> Void, failure: @escaping () -> Void)
}

class HomeScreenPresenter: HomeScreenPresenterProtocol {
    
    var view: HomeScreenVC
    var interactor: HomeScreenInteractor
    var router: HomeScreenRouter
    
    init(view: HomeScreenVC, interactor: HomeScreenInteractor, router: HomeScreenRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func fetchData(success: @escaping () -> Void, failure: @escaping () -> Void) {
        self.interactor.fetchTrendingMovies { [weak self] results in
            switch results {
            case .success(let titles):
                let titleArray = titles.getTitles()
                self?.view.updateViewWithData(with: titleArray)
                success()
            case .failure(let error):
                AppError.handle(error: error)
                failure()
            }
        }
    }
}
