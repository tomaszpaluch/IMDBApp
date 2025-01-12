//
//  MoviePosterView.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import SwiftUI

struct SmallPosterView: View {
    let data: ImageData?
    
    var body: some View {
        PosterView(data: data, width: 50, height: 50)
    }
}

struct BigPosterView: View {
    let data: ImageData?
    
    var body: some View {
        PosterView(data: data, width: 100, height: 100)
    }
}

struct PosterView: View {
    let data: ImageData?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Colors.gray)
            .frame(width: width, height: height)
            .overlay {
                if let imageData = data?.imageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
