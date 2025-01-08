//
//  PopularMoviesView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct PopularMoviesView: View {
    private var popularMovies = [
        PopularMoviesData(id: 1, posterImage: nil, movieTitle: "Star Wars"),
        PopularMoviesData(id: 2, favoriteButtonData: .init(isFavorite: true), posterImage: nil, movieTitle: "Star Trek"),
        PopularMoviesData(id: 3, posterImage: nil, movieTitle: "Back To The Future")
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(popularMovies) { movieData in
                PopularMoviesCell(data: movieData)
            }
        }
        .navigationTitle(Texts.PopularMovies.title)
        .navigationBarItems(trailing: FavoriteButton(data: .init(isFavorite: false)))
        .searchable(text: $searchText, prompt: Texts.PopularMovies.searchPrompt)
    }
}

#Preview {
    NavigationStack {
        PopularMoviesView()
    }
}
