//
//  HomeScreenPresenter.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

protocol HomeScreenPresenterProtocol  {
    func readyToNavigate(context: [Results], title: String)
}

class HomeScreenPresenter {
    var view: HomeScreenVC
    var interactor: HomeScreenInteractor
    var router: HomeScreenRouter
    
    init(view: HomeScreenVC, interactor: HomeScreenInteractor, router: HomeScreenRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func readyToNavigate(context: [Results], title: String, contentType: ContentType, language: String) {
        self.router.navigateToTitleList(context: context, title: title, contentType: contentType, language: language)
    }

    func fetchTrendingData(success: @escaping () -> Void, failure: @escaping () -> Void) {
        self.interactor.fetchTrendingMovies { [weak self] results in
            switch results {
            case .success(let titles):
                let titleArray = titles.getTitles()
                self?.view.updateViewWithTrendingData(with: titleArray)
                success()
            case .failure(let error):
                AppError.handle(error: error)
                failure()
            }
        }
    }

    func fetchTopMoviesData(success: @escaping () -> Void, failure: @escaping () -> Void, language: String, page: String) {
        self.interactor.fetchTopMovies(completion: { [weak self] results in
            switch results {
            case .success(let titles):
                let titleArray = titles.getTitles()
                self?.view.updateViewWithTopMoviesData(with: titleArray)
                success()
            case .failure(let error):
                AppError.handle(error: error)
                failure()
            }
        }, language: language, page: page)
    }

    func fetchTopSeriesData(success: @escaping () -> Void, failure: @escaping () -> Void, language: String, page: String) {
        self.interactor.fetchTopSeries(completion: { [weak self] results in
            switch results {
            case .success(let titles):
                let titleArray = titles.getTitles()
                self?.view.updateViewWithTopSeriesData(with: titleArray)
                success()
            case .failure(let error):
                AppError.handle(error: error)
                failure()
            }
        }, language: language, page: page)
    }
}

extension HomeScreenPresenter {
    func fetchData(for type: FetchType, success: @escaping () -> Void, failure: @escaping () -> Void, language: String, page: String) {
        switch type {
        case .trendingMovies:
            fetchTrendingData(success: success, failure: failure)
        case .topMovies:
            fetchTopMoviesData(success: success, failure: failure, language: language, page: page)
        case .topSeries:
            fetchTopSeriesData(success: success, failure: failure, language: language, page: page)
        }
    }
}
