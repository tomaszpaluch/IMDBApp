//
//  PopularMoviesResponseMapper.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

struct PopularMoviesResponseMapper {
    static func map(_ response: PopularMoviesResponse) -> PopularMoviesData? {
        guard
            let posterPath = response.posterPath,
            let originalTitle = response.originalTitle
        else { return nil }
        
        return .init(
            posterImage: .init(posterPath: posterPath),
            movieTitle: originalTitle
        )
    }
}
