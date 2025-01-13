//
//  FavoriteMoviesPersistenceWorker.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 13/01/2025.
//

import Foundation

class FavoriteMoviesPersistenceWorker: PersistenceWorker<[Int]> {
    init(persistenceDirectoryURL: URL) {
        super.init(
            persistenceDirectoryURL: persistenceDirectoryURL,
            fileName: "favorites"
        )
    }
}
