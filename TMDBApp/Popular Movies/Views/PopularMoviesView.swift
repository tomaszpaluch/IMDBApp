//
//  PopularMoviesView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct PopularMoviesView: View {
    @ObservedObject var viewModel: PopularMoviesViewModel
    
    @State private var searchText = ""
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
        .navigationBarItems(trailing: FavoriteButton(data: .init(isFavorite: false)))
        .searchable(text: $searchText, prompt: Texts.PopularMovies.searchPrompt)
        .alert(isPresented: .init { viewData.errorMessage != nil } set: { _ in }) {
            Alert(
                title: Text("Wystąpił błąd"),
                message:  viewData.errorMessage.map { Text($0) },
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    NavigationStack {
        PopularMoviesView(
            viewModel: .init(
                popularMoviesPagination: PopularMoviesPagination(
                    service: PopularMoviesApiMock()
                )
            )
        )
    }
}
