//
//  FetchType.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

enum FetchType: String {
    case trendingMovies = "Trending Movies"
    case topMovies = "Top Movies"
    case topSeries = "Top Series"

    var description: String {
        return self.rawValue
    }
}
