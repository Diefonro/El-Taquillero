//
//  HomeScreenInteractor.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

protocol HomeScreenInteractorProtocol {
    func fetchTrendingMovies(completion: @escaping (Result<Titles, Error>) -> Void)
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
}
