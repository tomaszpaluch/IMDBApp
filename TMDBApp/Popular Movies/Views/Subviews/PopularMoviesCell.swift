//
//  PopularMoviesCell.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct PopularMoviesCell: View {
    let data: PopularMoviesData
    
    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: 16) {
                FavoriteButton(data: data.favoriteButtonData)
                
                MoviePosterView(data: data.posterImage)
                
                Text(data.movieTitle)
                    .foregroundStyle(Colors.link)
            }
        }
        .onAppear {
            data.send(.appeared)
        }
    }
}
