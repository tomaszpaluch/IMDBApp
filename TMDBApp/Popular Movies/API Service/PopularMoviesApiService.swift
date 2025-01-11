//
//  PopularMoviesApiService.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Combine

protocol PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError>
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesCellData], ApiError>
}

struct PopularMoviesAPIService: PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesCellData], ApiError> {
        DiscoverApiService.getMovies(for: page)
            .map { data in data.results?.compactMap { PopularMoviesResponseMapper.map($0) } ?? []}
            .eraseToAnyPublisher()
    }
    
    /*It may be worth to consider using another mapper, error throwing when totalPages == nil*/
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        DiscoverApiService.getMovies(for: page)
            .map { data in (
                data.results?.compactMap { PopularMoviesResponseMapper.map($0) } ?? [],
                data.totalPages ?? 1
            )}
            .eraseToAnyPublisher()
    }
}
