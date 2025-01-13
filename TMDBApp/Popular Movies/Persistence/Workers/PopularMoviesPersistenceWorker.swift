//
//  PopularMoviesPersistenceWorker.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 13/01/2025.
//

import Foundation

class PopularMoviesPersistenceWorker: PersistenceWorker<PopularMoviesPersistenceWorker.PopularMoviesPersistenceData> {
    struct PopularMoviesPersistenceData: Codable {
        struct PopularMoviesData: Codable {
            let id: Int
            let posterImagePath: String?
            let movieTitle: String
        }
        
        let searchPhrase: String?
        let items: [PopularMoviesData]
    }
    
    init(persistenceDirectoryURL: URL) {
        super.init(
            persistenceDirectoryURL: persistenceDirectoryURL,
            fileName: "popularMovies"
        )
    }
}
