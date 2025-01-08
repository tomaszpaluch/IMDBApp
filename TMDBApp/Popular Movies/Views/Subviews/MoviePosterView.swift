//
//  MoviePosterView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct MoviePosterView: View {
    let data: PopularMoviesData.ImageData?
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Colors.gray)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: 50, height: 50)
    }
}
