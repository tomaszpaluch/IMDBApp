//
//  SearchAPIService.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Combine

protocol SearchAPIServiceable: PopularMoviesApiServiceable {
    init(searchPhrase: String)
}

struct SearchAPIService: SearchAPIServiceable {
    private let searchPhrase: String
    
    init(searchPhrase: String) {
        self.searchPhrase = searchPhrase
    }

    /*It may be worth to consider using another mapper, error throwing when totalPages == nil*/
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        SearchApiRequest.getMovies(with: searchPhrase, for: page)
            .map { data in (
                data.results?.compactMap {
                    PopularMoviesResponseMapper.map($0)
                } ?? [],
                data.totalPages ?? 1
            )}
            .eraseToAnyPublisher()
    }
}
