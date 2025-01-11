//
//  PopularMoviesResponseMapper.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

struct PopularMoviesResponseMapper {
    static func map(_ response: PopularMoviesResponse) -> PopularMoviesCellData? {
        guard
            let id = response.id,
            let posterPath = response.posterPath,
            let originalTitle = response.originalTitle
        else { return nil }
        
        return .init(
            id: id,
            posterImage: .init(posterPath: posterPath),
            movieTitle: originalTitle
        )
    }
}
