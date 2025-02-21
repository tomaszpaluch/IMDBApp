//
//  ContentView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RouterView {
            PopularMoviesView(
                viewModel: .init(
                    logic: popularMoviesLogicFactory
                )
            )
        }
    }
    
    var popularMoviesLogicFactory: PopularMoviesLogicable {
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

#Preview {
    ContentView()
}
