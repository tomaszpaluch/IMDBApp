//
//  ContentView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationStack {
                PopularMoviesView(
                    viewModel: .init(
                        logic: PopularMoviesLogic(
                            popularMoviesPaginationFactory: PopularMoviesPaginationFactory<
                            PopularMoviesPagination,
                            SearchAPIService,
                            DiscoverAPIService>(),
                            favoriteMoviesPersistence: FavoriteMoviesPersistence()
                        )
                    )
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
