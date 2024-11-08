//
//  HomeEndpoints.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import Foundation

enum HomeEndpoints {
    case trendingMovies
    case topMovies(titleProperties: TitleProperties)
    case topSeries(titleProperties: TitleProperties)
}

struct TitleProperties {
    var page: String
    var language: String
}

extension HomeEndpoints: Endpoint {
    
    var path: String {
        switch self {
        case .trendingMovies:
            return "/3/trending/all/week"
        case .topMovies:
            return "/3/movie/top_rated"
        case .topSeries:
            return "/3/tv/top_rated"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .trendingMovies:
            return [URLQueryItem(name: "language", value: "es-ES")]
        case .topMovies(let properties), .topSeries(let properties):
            
            let language = properties.language
            let page = properties.page
            return [
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: page)
            ]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .trendingMovies, .topMovies, .topSeries:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .trendingMovies, .topMovies, .topSeries:
            let bearerToken = ReadToken.readBearerToken()
            return [
                "Authorization" : "Bearer \(bearerToken)",
                "accept" : "application/json"
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .trendingMovies, .topMovies, .topSeries:
            return nil
        }
    }
}
