//
//  PopularMoviesLogic.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 11/01/2025.
//

import Combine

class PopularMoviesLogic {
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
        case loadNextPage
    }
    
    enum Output {
        case changeFavStatus(Bool)
        case addData([PopularMoviesCellData])
        case showData([PopularMoviesCellData])
    }
    
    private let popularMoviesPagination: PopularMoviesPaginationable
    private var storage: Storage
    
    private let eventRelay: PassthroughSubject<Output, ApiError>
    var events: AnyPublisher<Output, ApiError> { eventRelay.eraseToAnyPublisher() }
    private var subscriptions: Set<AnyCancellable>
    
    init(popularMoviesPagination: PopularMoviesPaginationable) {
        self.popularMoviesPagination = popularMoviesPagination
        self.storage = Storage()
        
        subscriptions = []
        eventRelay = .init()
        
        setupBinding()
    }
    
    private func setupBinding() {
        popularMoviesPagination.events
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.eventRelay.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] event in
                if case let .data(items) = event {
                    self?.setData(items)
                }
            }
            .store(in: &subscriptions)
    }
    
    private func setData(_ items: [PopularMoviesCellData]) {
        storage.data = items
        eventRelay.send(.addData(items))
    }
    
    func send(_ input: Input) {
        switch input {
        case .changeShowFavsOnlyStatus:
            storage.showFavsOnly = !storage.showFavsOnly
            showFilteredFavs()
            eventRelay.send(.changeFavStatus(storage.showFavsOnly))
        case let .changeFavStatus(id: id):
            changeFavStatus(for: id)
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
        
        eventRelay.send(.showData(storage.data))
    }

    private func loadNextPage() {
        if !storage.showFavsOnly {
            popularMoviesPagination.loadNextPage()
        }
    }
}
