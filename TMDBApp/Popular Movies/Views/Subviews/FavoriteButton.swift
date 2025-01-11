//
//  FavoriteButton.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct FavoriteButton: View {
    let data: FavoriteButtonData
    
    var body: some View {
        Button {
            withAnimation {
                data.send(.changeState)
            }
        } label: {
            Image(systemName: data.isFavorite ? "star.fill" : "star")
                .foregroundStyle(data.isFavorite ? Colors.selected : Colors.unselected)
        }
    }
}
