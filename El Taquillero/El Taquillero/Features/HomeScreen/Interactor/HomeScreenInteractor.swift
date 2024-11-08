//
//  HomeScreenInteractor.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

protocol HomeScreenInteractorProtocol {
   
}

class HomeScreenInteractor: HomeScreenInteractorProtocol {
    
    var homeServices = HomeServices()
    
    func fetchTrendingMovies(completion: @escaping (Result<Titles, Error>) -> Void) {
        Task(priority: .userInitiated) {
            let result = await self.homeServices.getTrendingMovies()
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopMovies(completion: @escaping (Result<Titles, Error>) -> Void, language: String, page: String) {
        Task(priority: .userInitiated) {
            let result = await self.homeServices.getTopRatedMovies(language: language, page: page)
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopSeries(completion: @escaping (Result<Titles, Error>) -> Void, language: String, page: String) {
        Task(priority: .userInitiated) {
            let result = await self.homeServices.getTopRatedSeries(language: language, page: page)
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
