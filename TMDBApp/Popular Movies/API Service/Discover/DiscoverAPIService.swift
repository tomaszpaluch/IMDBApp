//
//  DiscoverAPIService.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Combine

protocol DiscoverApiServiceable: PopularMoviesApiServiceable {
    init()
}

struct DiscoverAPIService: DiscoverApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesCellData], ApiError> {
        DiscoverApiRequest.getMovies(for: page)
            .map { data in
                data.results?.compactMap {
                    PopularMoviesResponseMapper.map($0)
                } ?? []
            }
            .eraseToAnyPublisher()
    }
    
    /*It may be worth to consider using another mapper, error throwing when totalPages == nil*/
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        DiscoverApiRequest.getMovies(for: page)
            .map { data in (
                data.results?.compactMap {
                    PopularMoviesResponseMapper.map($0)
                } ?? [],
                data.totalPages ?? 1
            )}
            .eraseToAnyPublisher()
    }
}
