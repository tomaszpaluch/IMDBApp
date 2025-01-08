//
//  PopularMoviesData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import Foundation
import Combine

struct PopularMoviesData: Identifiable {
    struct ImageData {
        let imagePath: URL
        let imageData: Data?
    }
    
    let id: Int
    let favoriteButtonData: FavoriteButtonData
    let posterImage: ImageData?
    let movieTitle: String
    
    init(id: Int, favoriteButtonData: FavoriteButtonData = .initial, posterImage: ImageData?, movieTitle: String) {
        self.id = id
        self.favoriteButtonData = favoriteButtonData
        self.posterImage = posterImage
        self.movieTitle = movieTitle
    }
}
