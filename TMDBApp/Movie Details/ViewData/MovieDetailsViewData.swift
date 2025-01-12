//
//  MovieDetailsViewData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Combine

struct MovieDetailsViewData: Equatable, Hashable {
    static func == (lhs: MovieDetailsViewData, rhs: MovieDetailsViewData) -> Bool {
        lhs.movieTitle == rhs.movieTitle
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movieTitle)
    }
    
    enum Output {
        case favoriteButton(FavoriteButtonData.Output)
    }
    
    let id: Int
    var favoriteButtonData: FavoriteButtonData
    var posterImage: ImageData?
    let movieTitle: String
    var overview: String?
    var releaseDate: String?
    var spokenLanguages: [String]?
    var isLoading: Bool

    var errorMessage: String?
    
    private var eventRelay: PassthroughSubject<Output, Never>
    var events: AnyPublisher<Output, Never> { eventRelay.eraseToAnyPublisher() }
    private var subscriptions: Set<AnyCancellable>
    
    init(id: Int, favoriteButtonData: FavoriteButtonData = .initial, posterImage: ImageData?, movieTitle: String, errorMessage: String? = nil, isLoading: Bool = false) {
        self.id = id
        self.favoriteButtonData = favoriteButtonData
        self.posterImage = posterImage
        self.movieTitle = movieTitle
        self.errorMessage = errorMessage
        self.isLoading = isLoading

        eventRelay = .init()
        subscriptions = []
        
        favoriteButtonData.events
            .sink { [self] event in
                eventRelay.send(.favoriteButton(event))
            }
            .store(in: &subscriptions)
    }
}
