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
