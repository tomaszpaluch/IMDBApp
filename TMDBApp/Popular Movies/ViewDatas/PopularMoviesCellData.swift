//
//  PopularMoviesData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import Foundation
import Combine

struct PopularMoviesCellData: Identifiable {
    enum Input {
        case appeared
    }
    
    enum Output {
        case favoriteButton(FavoriteButtonData.Output)
        case appeared
    }
    
    struct ImageData {
        let posterPath: String
        let imageData: Data?
        
        init(posterPath: String, imageData: Data? = nil) {
            self.posterPath = posterPath
            self.imageData = imageData
        }
    }
    
    let id: Int
    var favoriteButtonData: FavoriteButtonData
    let posterImage: ImageData?
    let movieTitle: String
    
    private var eventRelay: PassthroughSubject<Output, Never>
    var events: AnyPublisher<Output, Never> { eventRelay.eraseToAnyPublisher() }
    private var subscriptions: Set<AnyCancellable>
    
    init(id: Int, favoriteButtonData: FavoriteButtonData = .initial, posterImage: ImageData?, movieTitle: String) {
        self.id = id
        self.favoriteButtonData = favoriteButtonData
        self.posterImage = posterImage
        self.movieTitle = movieTitle
        
        eventRelay = .init()
        subscriptions = []
        
        favoriteButtonData.events
            .sink { [self] event in
                eventRelay.send(.favoriteButton(event))
            }
            .store(in: &subscriptions)
    }
    
    func send(_ input: Input) {
        switch input {
        case .appeared:
            eventRelay.send(.appeared)
        }
    }
}
