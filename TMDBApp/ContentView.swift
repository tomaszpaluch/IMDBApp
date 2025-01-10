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
                        popularMoviesPagination: PopularMoviesPagination(
                            service: PopularMoviesAPIService()
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
