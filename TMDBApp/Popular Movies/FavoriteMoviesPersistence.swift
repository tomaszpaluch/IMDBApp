//
//  FavoriteMoviesPersistence.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 11/01/2025.
//

import Foundation
import Combine

protocol FavoriteMoviesPersistenceable {
    func saveFav(for itemID: Int)
    func isFaved(itemID: Int) -> Bool
}

class FavoriteMoviesPersistence: FavoriteMoviesPersistenceable {
    private let persistenceDirectory: URL
    private let fileURL: URL
    
    private let saveRelay: PassthroughSubject<Void, Never>
    private var subscription: AnyCancellable?
    private var favoritedMovies: [Int]
    
    init?() {
        let directoryName = "persistance"
        let fileName = "favorites"
        
        self.favoritedMovies = []
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        persistenceDirectory = documentsDirectory.appendingPathComponent(directoryName)
        fileURL = persistenceDirectory.appendingPathComponent(fileName)
        
        saveRelay = .init()
        subscription = saveRelay
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.saveFile()
            }
        
        loadFile()
    }
    
    private func saveFile() {
        do {
            let data = try JSONEncoder().encode(favoritedMovies)
            
            if !FileManager.default.fileExists(atPath: persistenceDirectory.path) {
                try FileManager.default.createDirectory(at: persistenceDirectory, withIntermediateDirectories: false)
            }
            
            try data.write(to: fileURL)
        } catch {
            print("Error saving JSON: \(error)")
        }
    }
    
    private func loadFile() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
           
        do {
            favoritedMovies = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func saveFav(for itemID: Int) {
        if let index = favoritedMovies.firstIndex(of: itemID) {
            favoritedMovies.remove(at: index)
        } else {
            favoritedMovies.append(itemID)
        }
        
        saveRelay.send()
    }
    
    func isFaved(itemID: Int) -> Bool {
        favoritedMovies.contains(itemID)
    }
}
