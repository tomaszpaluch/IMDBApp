//
//  MoviePosterView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct MoviePosterView: View {
    let data: PopularMoviesCellData.ImageData?
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Colors.gray)
            .frame(width: 50, height: 50)
            .overlay {
                if let imageData = data?.imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                }
            }
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
