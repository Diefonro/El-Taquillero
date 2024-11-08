//
//  Titles.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import Foundation

// MARK: - Titles
struct Titles: Codable {
    var page: Int?
    var results: [Results]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    func getTitles() -> [Results] {
        guard let results = results, !results.isEmpty else {
            return []
        }
        return results
    }
}

// MARK: - Result
struct Results: Codable {
    var backdropPath: String?
    var id: Int?
    var title, originalTitle, overview, posterPath: String?
    var mediaType: String?
    var adult: Bool?
    var originalLanguage: String?
    var genreIDS: [Int]?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var name, originalName, firstAirDate: String?
    var originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
    
    func getPosterPath() -> String {
        guard let posterPath = posterPath else {
            return ""
        }
        return posterPath
    }
    
    func getGenres() -> [Int] {
        guard let genreIDS = genreIDS, !genreIDS.isEmpty else {
            return []
        }
        return genreIDS
    }
}
