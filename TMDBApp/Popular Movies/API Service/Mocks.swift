//
//  Mocks.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Foundation
import Combine

struct PopularMoviesApiDelayedMock: PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesData], totalPageCount: Int), ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .success(
                        (
                            [
                                PopularMoviesData(posterImage: nil, movieTitle: "Star Wars"),
                                PopularMoviesData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                                PopularMoviesData(posterImage: nil, movieTitle: "Back To The Future"),
                                PopularMoviesData(posterImage: nil, movieTitle: "Matrix"),
                                PopularMoviesData(posterImage: nil, movieTitle: "Robocop"),
                                PopularMoviesData(posterImage: nil, movieTitle: "Lord of the Rings"),
                                PopularMoviesData(posterImage: nil, movieTitle: "Mickey 17"),
                                PopularMoviesData(posterImage: nil, movieTitle: "James Bond"),
                            ],
                            1
                        )
                    )
                )
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesData], ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .success(
                        [
                            PopularMoviesData(posterImage: nil, movieTitle: "Star Wars"),
                            PopularMoviesData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Back To The Future"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Matrix"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Robocop"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Lord of the Rings"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Mickey 17"),
                            PopularMoviesData(posterImage: nil, movieTitle: "James Bond"),
                        ]
                    )
                )
            }
        }
        .eraseToAnyPublisher()
    }
}

struct PopularMoviesApiDelayedFailureMock: PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesData], totalPageCount: Int), ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .failure(ApiError.unknownError)
                )
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesData], ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .failure(ApiError.unknownError)
                )
            }
        }
        .eraseToAnyPublisher()
    }
}

struct PopularMoviesApiMock: PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesData], totalPageCount: Int), ApiError> {
        Future { promise in
            promise(
                .success(
                    (
                        [
                            PopularMoviesData(posterImage: nil, movieTitle: "Star Wars"),
                            PopularMoviesData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Back To The Future"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Matrix"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Robocop"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Lord of the Rings"),
                            PopularMoviesData(posterImage: nil, movieTitle: "Mickey 17"),
                            PopularMoviesData(posterImage: nil, movieTitle: "James Bond"),
                        ],
                        1
                    )
                )
            )
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesData], ApiError> {
        Future { promise in
            promise(
                .success(
                    [
                        PopularMoviesData(posterImage: nil, movieTitle: "Star Wars"),
                        PopularMoviesData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                        PopularMoviesData(posterImage: nil, movieTitle: "Back To The Future"),
                        PopularMoviesData(posterImage: nil, movieTitle: "Matrix"),
                        PopularMoviesData(posterImage: nil, movieTitle: "Robocop"),
                        PopularMoviesData(posterImage: nil, movieTitle: "Lord of the Rings"),
                        PopularMoviesData(posterImage: nil, movieTitle: "Mickey 17"),
                        PopularMoviesData(posterImage: nil, movieTitle: "James Bond"),
                    ]
                )
            )
        }
        .eraseToAnyPublisher()
    }
}

