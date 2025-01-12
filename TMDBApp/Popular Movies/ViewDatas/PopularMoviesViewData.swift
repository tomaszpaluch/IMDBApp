//
//  PopularMoviesViewData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Combine

struct PopularMoviesViewData {
    enum Input {
        case searchPhrase(String)
    }
    
    enum Output {
        case favoriteButton(FavoriteButtonData.Output)
        case searchPhrase(String)
        case popularMoviesData(PopularMoviesCellData.Output, at: Int)
    }
    
    static let initial: Self = .init(favoriteButtonData: .initial, items: [], isLoading: true)
    
    var favoriteButtonData: FavoriteButtonData
    var items: [PopularMoviesCellData]
    var searchText: String
    var isLoading: Bool

    var errorMessage: String?
    
    private var eventRelay: PassthroughSubject<Output, Never>
    var events: AnyPublisher<Output, Never> { eventRelay.eraseToAnyPublisher() }
    private var subscriptions: Set<AnyCancellable>
    
    init(favoriteButtonData: FavoriteButtonData, items: [PopularMoviesCellData], searchText: String? = nil, errorMessage: String? = nil, isLoading: Bool) {
        self.favoriteButtonData = favoriteButtonData
        self.items = items
        self.searchText = searchText ?? ""
        self.errorMessage = errorMessage
        self.isLoading = isLoading

        eventRelay = .init()
        subscriptions = []
        
        favoriteButtonData.events
            .sink { [self] event in
                eventRelay.send(.favoriteButton(event))
            }
            .store(in: &subscriptions)
        
        items.enumerated().forEach { index, item in
            item.events
                .sink { [self] event in
                    eventRelay.send(.popularMoviesData(event, at: index))
                }
                .store(in: &subscriptions)
        }
    }
    
    func send(_ input: Input) {
        switch input {
        case let .searchPhrase(phrase):
            eventRelay.send(.searchPhrase(phrase))
        }
    }
}
