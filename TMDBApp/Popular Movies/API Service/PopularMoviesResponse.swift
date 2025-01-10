//
//  PopularMoviesResponse.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

import Foundation

struct PopularMoviesResponse: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
