//
//  ImageData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Foundation

struct ImageData {
    let posterPath: String
    var imageData: Data?
    
    init(posterPath: String, imageData: Data? = nil) {
        self.posterPath = posterPath
        self.imageData = imageData
    }
}
