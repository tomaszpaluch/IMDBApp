//
//  Mocks.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Foundation
import Combine

struct PopularMoviesApiDelayedMock: DiscoverApiServiceable {
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

struct PopularMoviesApiDelayedFailureMock: DiscoverApiServiceable {
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

struct PopularMoviesApiMock: DiscoverApiServiceable {
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

struct SearchApiMock: SearchAPIServiceable {
    init(searchPhrase: String) { }
    
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        Future { promise in
            promise(
                .success(
                    (
                        [
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search Star Wars"),
                            PopularMoviesCellData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search Back To The Future"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search Matrix"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search Robocop"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search Lord of the Rings"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search Mickey 17"),
                            PopularMoviesCellData(posterImage: nil, movieTitle: "Search James Bond"),
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
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search Star Wars"),
                        PopularMoviesCellData(favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search Back To The Future"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search Matrix"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search Robocop"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search Lord of the Rings"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search Mickey 17"),
                        PopularMoviesCellData(posterImage: nil, movieTitle: "Search James Bond"),
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

struct SearchAPIServiceMock: SearchAPIServiceable {
    private let data: [PopularMoviesCellData]
    private let itemsPerPage: Int
    private let totalPageCount: Int

    init(searchPhrase: String) {
        data = PopularMoviesCellDataRepository.data.filter {
            $0.movieTitle.contains(searchPhrase)
        }
        itemsPerPage = 10
        totalPageCount = Int((Float(data.count) / Float(itemsPerPage)).rounded(.up))
    }
    
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        let pageData: [PopularMoviesCellData]
        if (page - 1) * itemsPerPage > data.count {
            pageData = []
        } else {
            pageData = Array(data[(page - 1) * itemsPerPage ..< min(page * itemsPerPage, data.count)])
        }
        return Just((pageData, totalPageCount))
            .setFailureType(to: ApiError.self)
            .eraseToAnyPublisher()
    }
}

struct SearchAPIServiceFailureMock: SearchAPIServiceable {
    private let data: [PopularMoviesCellData]
    private let itemsPerPage: Int
    private let totalPageCount: Int

    init(searchPhrase: String) {
        data = PopularMoviesCellDataRepository.data.filter {
            $0.movieTitle.contains(searchPhrase)
        }
        itemsPerPage = 10
        totalPageCount = Int((Float(data.count) / Float(itemsPerPage)).rounded(.up))
    }
    
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        Fail(error: ApiError.unknownError)
            .eraseToAnyPublisher()
    }
}

struct DiscoverAPIServiceMock: DiscoverApiServiceable {
    static let itemsPerPage: Int = 10
    
    private let totalDataCount: Int
    private let totalPageCount: Int
    
    init() {
        totalDataCount = PopularMoviesCellDataRepository.data.count
        totalPageCount = Int((Float(totalDataCount) / Float(Self.itemsPerPage)).rounded(.up))
    }
    
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        let pageData: [PopularMoviesCellData]
        let itemsPerPage = Self.itemsPerPage
        if (page - 1) * itemsPerPage > totalDataCount {
            pageData = []
        } else {
            pageData = Array(PopularMoviesCellDataRepository.data[(page - 1) * itemsPerPage ..< min(page * itemsPerPage, totalDataCount)])
        }
        return Just((pageData, totalPageCount))
            .setFailureType(to: ApiError.self)
            .eraseToAnyPublisher()
    }
}

struct DiscoverAPIServiceFailureMock: DiscoverApiServiceable {
    static let itemsPerPage: Int = 10
    
    private let totalDataCount: Int
    private let totalPageCount: Int
    
    init() {
        totalDataCount = PopularMoviesCellDataRepository.data.count
        totalPageCount = Int((Float(totalDataCount) / Float(Self.itemsPerPage)).rounded(.up))
    }
    
    func getMovies(for page: Int) -> AnyPublisher<([PopularMoviesCellData], totalPageCount: Int), ApiError> {
        Fail(error: ApiError.unknownError)
            .eraseToAnyPublisher()
    }
}

struct PopularMoviesCellDataRepository {
    static var data: [PopularMoviesCellData] = {
        let letters = ["Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota", "Upsilon", "Omega"]
        return letters.reduce([PopularMoviesCellData]()) { result, element in
            let newMovies = (1...5).map {
                PopularMoviesCellData(
                    id: result.count + $0,
                    favoriteButtonData: .init(isFavorite: false),
                    posterImage: nil,
                    movieTitle: "\(element) \($0)"
                )
            }
            
            var updatedResult = result
            updatedResult.append(contentsOf: newMovies)
            return updatedResult
        }
    }()
}
