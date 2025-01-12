//
//  PopularMoviesLogic.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 11/01/2025.
//

import Foundation
import Combine

protocol PopularMoviesLogicable {
    var events: AnyPublisher<PopularMoviesLogic.Output, ApiError> { get }
    
    func send(_ input: PopularMoviesLogic.Input)
}

class PopularMoviesLogic: PopularMoviesLogicable {
    struct Storage {
        var searchPhrase: String?
        var showFavsOnly: Bool
        var data: [PopularMoviesCellData]
        
        init() {
            showFavsOnly = false
            data = []
        }
    }
    
    enum Input {
        case changeShowFavsOnlyStatus
        case changeFavStatus(id: Int)
        case startSearch(for: String)
        case loadNextPage
    }
    
    enum Output {
        case changeFavStatus(Bool)
        case showData([PopularMoviesCellData])
        case setSearchText(String)
        case showLoading(Bool)
    }
    
    private let popularMoviesPaginationFactory: PopularMoviesPaginationFactorable
    private let favoriteMoviesPersistence: FavoriteMoviesPersistenceable?
    private var currentPagination: PopularMoviesPaginationable
    private var storage: Storage
    
    private let searchRelay: PassthroughSubject<String, Never>
    private let eventRelay: PassthroughSubject<Output, ApiError>
    var events: AnyPublisher<Output, ApiError> { eventRelay.eraseToAnyPublisher() }
    private var searchSubscription: AnyCancellable?
    private var paginationSubscription: AnyCancellable?
    
    init(
        popularMoviesPaginationFactory: PopularMoviesPaginationFactorable,
        favoriteMoviesPersistence: FavoriteMoviesPersistenceable?
    ) {
        self.popularMoviesPaginationFactory = popularMoviesPaginationFactory
        self.favoriteMoviesPersistence = favoriteMoviesPersistence
        self.currentPagination = popularMoviesPaginationFactory.make()
        self.storage = Storage()
        
        searchRelay = .init()
        eventRelay = .init()
        
        setupBinding()
    }
    
    private func setupBinding() {
        searchSubscription = searchRelay
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] phrase in
                self?.setSearchPhrase(phrase)
            }
        
        setupPaginationBinding()
    }
    
    func send(_ input: Input) {
        switch input {
        case .changeShowFavsOnlyStatus:
            storage.showFavsOnly = !storage.showFavsOnly
            showFilteredFavs()
            eventRelay.send(.changeFavStatus(storage.showFavsOnly))
        case let .changeFavStatus(id: id):
            changeFavStatus(for: id)
        case let .startSearch(phrase):
            startSearch(for: phrase)
        case .loadNextPage:
            loadNextPage()
        }
    }
    
    private func showFilteredFavs() {
        var tempData = storage.data
        if storage.showFavsOnly {
            tempData = tempData.filter { $0.favoriteButtonData.isFavorite }
        }
        eventRelay.send(.showData(tempData))
    }
    
    private func changeFavStatus(for itemID: Int) {
        guard let index = storage.data.firstIndex(where: { $0.id == itemID }) else { return }
        
        let oldData = storage.data[index]
        storage.data[index] = .init(
            id: oldData.id,
            favoriteButtonData: .init(
                isFavorite: !oldData.favoriteButtonData.isFavorite
            ),
            posterImage: oldData.posterImage,
            movieTitle: oldData.movieTitle
        )
        
        favoriteMoviesPersistence?.saveFav(for: oldData.id)
        eventRelay.send(.showData(storage.data))
    }
    
    private func startSearch(for phrase: String) {
        print("startSearch")
        searchRelay.send(phrase)
    }
    
    private func setSearchPhrase(_ phrase: String) {
        let phrase = phrase == "" ? nil : phrase
        print("setSearchPhrase: \(phrase)")
        guard storage.searchPhrase != phrase else { return }
        
        storage.searchPhrase = phrase
        currentPagination = popularMoviesPaginationFactory.make(for: phrase)
        setupPaginationBinding()
        
        storage.data = []
        eventRelay.send(.showData(storage.data))
        eventRelay.send(.showLoading(true))
        currentPagination.loadNextPage()
    }
    
    private func setupPaginationBinding() {
        paginationSubscription?.cancel()
        paginationSubscription = currentPagination.events
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.eventRelay.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] event in
                if case let .data(items) = event {
                    self?.setData(items)
                }
            }
    }
    
    private func setData(_ items: [PopularMoviesCellData]) {
        let items = favoriteMoviesPersistence.map { persistence in
            items.map {
                var copy = $0
                copy.favoriteButtonData.isFavorite =  persistence.isFaved(itemID: $0.id)
                return copy
            }
        } ?? items
        storage.data += items
        showFilteredFavs()
        eventRelay.send(.setSearchText(storage.searchPhrase ?? ""))
        eventRelay.send(.showLoading(false))
    }

    private func loadNextPage() {
        if !storage.showFavsOnly {
            currentPagination.loadNextPage()
        }
    }
}
