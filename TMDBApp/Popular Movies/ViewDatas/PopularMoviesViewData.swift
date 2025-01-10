//
//  PopularMoviesViewData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Combine

struct PopularMoviesViewData {
    enum Output {
        case favoriteButton(FavoriteButtonData.Output)
        case popularMoviesData(PopularMoviesData.Output, at: Int)
    }
    
    static let initial: Self = .init(favoriteButtonData: .initial, isLoading: true, items: [])
    
    var favoriteButtonData: FavoriteButtonData
    var isLoading: Bool
    var items: [PopularMoviesData]
    
    var errorMessage: String?
    
    private var eventRelay: PassthroughSubject<Output, Never>
    var events: AnyPublisher<Output, Never> { eventRelay.eraseToAnyPublisher() }
    private var subscriptions: Set<AnyCancellable>
    
    init(favoriteButtonData: FavoriteButtonData, isLoading: Bool, items: [PopularMoviesData], errorMessage: String? = nil) {
        self.favoriteButtonData = favoriteButtonData
        self.isLoading = isLoading
        self.items = items
        self.errorMessage = errorMessage
        
        eventRelay = .init()
        subscriptions = []
        
        items.enumerated().forEach { index, item in
            item.events
                .sink { [self] event in
                    eventRelay.send(.popularMoviesData(event, at: index))
                }
                .store(in: &subscriptions)
        }
    }
}
