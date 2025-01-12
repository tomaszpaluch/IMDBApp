//
//  PopularMoviesView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct PopularMoviesView: View {
    @ObservedObject var viewModel: PopularMoviesViewModel
    @EnvironmentObject var router: Router

    private var viewData: PopularMoviesViewData { viewModel.output.viewData }
    
    var body: some View {
        List {
            ForEach(viewData.items) { movieData in
                PopularMoviesCell(data: movieData)
            }
        }
        .listStyle(.plain)
        .overlay {
            if viewData.isLoading {
                Color.white
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView()
                            .controlSize(.large)
                    }
            }
        }
        .navigationTitle(Texts.PopularMovies.title)
        .navigationBarItems(trailing: FavoriteButton(data: viewData.favoriteButtonData))
        .searchable(
            text: .init { viewData.searchText } set: { phrase in viewData.send(.searchPhrase(phrase)) },
            prompt: Texts.PopularMovies.searchPrompt
        )
        .alert(isPresented: .init { viewData.errorMessage != nil } set: { _ in }) {
            Alert(
                title: Text(Texts.ApiErrors.title),
                message:  viewData.errorMessage.map { Text($0) },
                dismissButton: .default(Text(Texts.Common.ok))
            )
        }
        .onReceive(viewModel.events) { event in
            switch event {
            case let .openDetails(data):
                router.navigateTo(.movieDetails(data))
            }
        }
    }
}

#Preview {
    NavigationStack {
        PopularMoviesView(
            viewModel: .init(
                logic: PopularMoviesLogic(
                    popularMoviesPaginationFactory: PopularMoviesPaginationFactory<
                        PopularMoviesPagination,
                        SearchApiMock,
                        PopularMoviesApiMock>(),
                    favoriteMoviesPersistence: FavoriteMoviesPersistence()
                )
            )
        )
    }
}
