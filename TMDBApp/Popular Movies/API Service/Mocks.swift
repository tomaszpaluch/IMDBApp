//
//  Mocks.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Foundation
import Combine

struct PopularMoviesApiDelayedMock: PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .success(
                        (
                            [
                                PopularMoviesCellData(posterImage: nil, movieTitle: "Star Wars"),
                                PopularMoviesCellData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                                PopularMoviesCellData(posterImage: nil, movieTitle: "Back To The Future"),
                                PopularMoviesCellData(posterImage: nil, movieTitle: "Matrix"),
                                PopularMoviesCellData(posterImage: nil, movieTitle: "Robocop"),
                                PopularMoviesCellData(posterImage: nil, movieTitle: "Lord of the Rings"),
                                PopularMoviesCellData(posterImage: nil, movieTitle: "Mickey 17"),
                                PopularMoviesCellData(posterImage: nil, movieTitle: "James Bond"),
                            ],
                            1
                        )
                    )
                )
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesCellData], ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .success(
                        [
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Star Wars"),
                            PopularMoviesCellData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Back To The Future"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Matrix"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Robocop"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Lord of the Rings"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Mickey 17"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "James Bond"),
                        ]
                    )
                )
            }
        }
        .eraseToAnyPublisher()
    }
}

struct PopularMoviesApiDelayedFailureMock: PopularMoviesApiServiceable {
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(
                    .failure(ApiError.unknownError)
                )
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesCellData], ApiError> {
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
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        Future { promise in
            promise(
                .success(
                    (
                        [
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Star Wars"),
                            PopularMoviesCellData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Back To The Future"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Matrix"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Robocop"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Lord of the Rings"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Mickey 17"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "James Bond"),
                        ],
                        1
                    )
                )
            )
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for page: Int) -> AnyPublisher<[PopularMoviesCellData], ApiError> {
        Future { promise in
            promise(
                .success(
                    [
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Star Wars"),
                        PopularMoviesCellData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Back To The Future"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Matrix"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Robocop"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Lord of the Rings"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Mickey 17"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "James Bond"),
                    ]
                )
            )
        }
        .eraseToAnyPublisher()
    }
}

fileprivate extension PopularMoviesCellData {
    init(favoriteButtonData: FavoriteButtonData = .initial, posterImage: ImageData?, movieTitle: String) {
        let pseudoUUID = UUID().uuidString.hashValue
        self.init(id: pseudoUUID, favoriteButtonData: favoriteButtonData, posterImage: posterImage, movieTitle: movieTitle)
    }
}
