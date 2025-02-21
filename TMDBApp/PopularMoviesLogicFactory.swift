//
//  PopularMoviesLogicFactory.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 21/02/2025.
//

import Foundation

struct PopularMoviesLogicFactory {
    static func make() -> PopularMoviesLogicable {
        if let value = ProcessInfo.processInfo.environment["useMockData"], value == "true" {
            PopularMoviesLogic(
                popularMoviesPaginationFactory: PopularMoviesPaginationFactoryMock(),
                imageAPIService: ImageAPIServiceFake(),
                popularMoviesPersistence: nil
            )
        } else {
            PopularMoviesLogic(
                popularMoviesPaginationFactory: PopularMoviesPaginationFactory<
                PopularMoviesPagination,
                SearchAPIService,
                DiscoverAPIService
                >(),
                imageAPIService: ImageAPIService(),
                popularMoviesPersistence: PopularMoviesPersistence()
            )
        }
    }
}
