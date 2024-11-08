//
//  HomeServices.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

protocol HomeServiceable {
    func getTrendingMovies() async -> Result<Titles, RequestError>
    func getTopRatedMovies(language: String, page: String) async -> Result<Titles, RequestError>
    func getTopRatedSeries(language: String, page: String) async -> Result<Titles, RequestError>
}

class HomeServices: HTTPRequest, HomeServiceable {
    func getTrendingMovies() async -> Result<Titles, RequestError> {
       return await sendRequest(endpoint: HomeEndpoints.trendingMovies, responseModel: Titles.self)
    }
    
    func getTopRatedMovies(language: String, page: String) async -> Result<Titles, RequestError> {
        return await sendRequest(endpoint: HomeEndpoints.topMovies(titleProperties: TitleProperties(page: page, language: language)), responseModel: Titles.self)
    }
    
    func getTopRatedSeries(language: String, page: String) async -> Result<Titles, RequestError> {
        return await sendRequest(endpoint: HomeEndpoints.topSeries(titleProperties: TitleProperties(page: page, language: language)), responseModel: Titles.self)
    }
}
