//
//  HomeEndpoints.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import Foundation

enum HomeEndpoints {
    case trendingMovies
}

extension HomeEndpoints: Endpoint {
    var path: String {
        switch self {
        case .trendingMovies:
            return "/3/trending/all/week"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .trendingMovies:
            return [URLQueryItem(name: "language", value: "es-ES")]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .trendingMovies:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .trendingMovies:
            let bearerToken = ReadToken.readBearerToken()
            return [
                "Authorization" : "Bearer \(bearerToken)",
                "accept" : "application/json"
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .trendingMovies:
            return nil
        }
    }
    
    
}
