//
//  HomeServices.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

protocol HomeServiceable {
    func getTrendingMovies() async -> Result<Titles, RequestError>
    func getTopRatedMovies() async -> Result<Titles, RequestError>
    func getTopRatedSeries() async -> Result<Titles, RequestError>
}

class HomeServices: HTTPRequest, HomeServiceable {
    func getTrendingMovies() async -> Result<Titles, RequestError> {
       return await sendRequest(endpoint: HomeEndpoints.trendingMovies, responseModel: Titles.self)
    }
    
    func getTopRatedMovies() async -> Result<Titles, RequestError> {
        return await sendRequest(endpoint: HomeEndpoints.topMovies, responseModel: Titles.self)
    }
    
    func getTopRatedSeries() async -> Result<Titles, RequestError> {
        return await sendRequest(endpoint: HomeEndpoints.topSeries, responseModel: Titles.self)
    }
}
