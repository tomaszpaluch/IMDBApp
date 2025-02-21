//
//  PopularMoviesCellDataRepository.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 21/02/2025.
//

struct PopularMoviesCellDataRepository {
    static var data: [PopularMoviesCellData] {
        MockMovieTitles.titles.enumerated().map { index, element in
            PopularMoviesCellData(
                id: index,
                favoriteButtonData: .init(isFavorite: false),
                posterImage: nil,
                movieTitle: element
            )
        }
    }
}
