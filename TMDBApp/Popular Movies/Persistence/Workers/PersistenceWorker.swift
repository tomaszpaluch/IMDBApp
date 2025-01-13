//
//  PersistenceWorker.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 13/01/2025.
//

import Foundation
import Combine

class PersistenceWorker<T: Codable> {
    struct PopularMoviesPersistenceData: Codable {
        struct PopularMoviesData: Codable {
            let id: Int
            let posterImagePath: String?
            let movieTitle: String
        }
        
        let searchPhrase: String?
        let items: [PopularMoviesData]
    }
    
    private let persistenceDirectoryURL: URL
    private let fileURL: URL
    
    private let saveRelay: PassthroughSubject<T, Never>
    private var subscription: AnyCancellable?
    
    init(persistenceDirectoryURL: URL, fileName: String) {
        self.persistenceDirectoryURL = persistenceDirectoryURL
        fileURL = persistenceDirectoryURL.appendingPathComponent(fileName)
        
        saveRelay = .init()
        subscription = saveRelay
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [self] data in
                proceedSavingFile(data)
            }
    }
    
    private func proceedSavingFile(_ data: T) {
        do {
            let data = try JSONEncoder().encode(data)
            
            if !FileManager.default.fileExists(atPath: persistenceDirectoryURL.path) {
                try FileManager.default.createDirectory(at: persistenceDirectoryURL, withIntermediateDirectories: false)
            }
            
            try data.write(to: fileURL)
        } catch {
            print("Error saving JSON: \(error)")
        }
    }
    
    func loadFile() -> T? {
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
           
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            return data
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        return nil
    }
    
    func saveFile(_ data: T) {
        saveRelay.send(data)
    }
}
