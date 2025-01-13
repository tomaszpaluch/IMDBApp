//
//  PopularMoviesPersistence.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 11/01/2025.
//

import Foundation
import Combine

protocol PopularMoviesPersistenceable {
    func save(_ type: PopularMoviesPersistence.SaveType)
    func load(_ type: PopularMoviesPersistence.LoadType)
}

struct PopularMoviesPersistence: PopularMoviesPersistenceable {
    enum SaveType {
        case popularMovies(PopularMoviesPersistenceWorker.PopularMoviesPersistenceData)
        case favorites([Int])
    }
    
    enum LoadType {
        case popularMovies((PopularMoviesPersistenceWorker.PopularMoviesPersistenceData) -> Void)
        case favorites(([Int]) -> Void)
    }
    
    let popularMoviesPersistenceWorker: PopularMoviesPersistenceWorker
    let favoriteMoviesPersistenceWorker: FavoriteMoviesPersistenceWorker
    
    init?() {
        let directoryName = "persistance"

        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let persistenceDirectory = documentsDirectory.appendingPathComponent(directoryName)

        popularMoviesPersistenceWorker = PopularMoviesPersistenceWorker(persistenceDirectoryURL: persistenceDirectory)
        favoriteMoviesPersistenceWorker = FavoriteMoviesPersistenceWorker(persistenceDirectoryURL: persistenceDirectory)
    }
    
    func save(_ type: SaveType) {
        switch type {
        case let .popularMovies(data):
            popularMoviesPersistenceWorker.saveFile(data)
        case let .favorites(data):
            favoriteMoviesPersistenceWorker.saveFile(data)
        }
    }
    
    func load(_ type: LoadType) {
        switch type {
        case let .popularMovies(completion):
            if let data = popularMoviesPersistenceWorker.loadFile() {
                completion(data)
            }
        case let .favorites(completion):
            if let data = favoriteMoviesPersistenceWorker.loadFile() {
                completion(data)
            }
        }
    }
}
