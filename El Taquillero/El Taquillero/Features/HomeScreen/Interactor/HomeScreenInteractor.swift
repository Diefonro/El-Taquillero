//
//  HomeScreenInteractor.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

protocol HomeScreenInteractorProtocol {
    func fetchData(service: @escaping () async -> Result<Titles, RequestError>, completion: @escaping (Result<Titles, Error>) -> Void)
}

class HomeScreenInteractor: HomeScreenInteractorProtocol {
    
    var homeServices = HomeServices()
    
    func fetchData(service: @escaping () async -> Result<Titles, RequestError>, completion: @escaping (Result<Titles, Error>) -> Void) {
        Task(priority: .userInitiated) {
            let result = await service()
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    func fetchTrendingMovies(completion: @escaping (Result<Titles, Error>) -> Void) {
        fetchData(service: self.homeServices.getTrendingMovies, completion: completion)
    }

    func fetchTopMovies(completion: @escaping (Result<Titles, Error>) -> Void) {
        fetchData(service: self.homeServices.getTopRatedMovies, completion: completion)
    }

    func fetchTopSeries(completion: @escaping (Result<Titles, Error>) -> Void) {
        fetchData(service: self.homeServices.getTopRatedSeries, completion: completion)
    }
}
