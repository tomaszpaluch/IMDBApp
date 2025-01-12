//
//  PopularMoviesViewModel.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import Foundation
import Combine


class PopularMoviesViewModel: ObservableObject {
    enum Policy {
        static let refreshDistance: Int = 10
    }
    
    struct Output {
        fileprivate let viewDataSubject: CurrentValueSubject<PopularMoviesViewData, Never>
        fileprivate var viewDataPublisher: AnyPublisher<PopularMoviesViewData, Never> {
            viewDataSubject.eraseToAnyPublisher()
        }
        var viewData: PopularMoviesViewData { viewDataSubject.value }
        
        init() {
            viewDataSubject = .init(.initial)
        }
    }
    
    private let logic: PopularMoviesLogicable
    
    let output: Output
    private var subscriptions: Set<AnyCancellable>
    private var viewDataSubscription: AnyCancellable?
    
    init(logic: PopularMoviesLogicable) {
        self.logic = logic
        
        output = Output()
        subscriptions = []
        
        setupBinding()
        logic.send(.loadNextPage)
    }
    
    private func setupBinding() {
        output.viewDataPublisher
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &subscriptions)
        
        logic.events
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.showError(error.localizedDescription)
                }
            } receiveValue: { [weak self] event in
                self?.proceedLogicEvent(event)
            }
            .store(in: &subscriptions)
    }
    
    private func showError(_ message: String) {
        var viewData = output.viewData
        viewData.errorMessage = message
        output.viewDataSubject.send(viewData)
    }
    
    private func proceedLogicEvent(_ event: PopularMoviesLogic.Output) {
        switch event {
        case let .changeFavStatus(value):
            changeFavStatus(value)
        case let .showData(items):
            setData(items)
        case let .setSearchText(phrase):
            setSearchText(phrase)
        case let .showLoading(value):
            showLoading(value)
        }
    }
    
    private func changeFavStatus(_ value: Bool) {
        var viewData = output.viewData
        viewData.favoriteButtonData.isFavorite.toggle()
        output.viewDataSubject.send(viewData)
    }
    
    private func setData(_ items: [PopularMoviesCellData]) {
        let viewData = PopularMoviesViewData(
            favoriteButtonData: output.viewData.favoriteButtonData,
            items: items,
            searchText: output.viewData.searchText,
            isLoading: output.viewData.isLoading
        )
        setupBinding(for: viewData)
        output.viewDataSubject.send(viewData)
    }
    
    private func setupBinding(for viewData: PopularMoviesViewData) {
        viewDataSubscription?.cancel()
        viewDataSubscription = viewData.events
            .sink { [weak self] event in
                switch event {
                case .favoriteButton:
                    print("favoriteButton")
                    self?.logic.send(.changeShowFavsOnlyStatus)
                case let .searchPhrase(phrase):
                    self?.logic.send(.startSearch(for: phrase))
                case let .popularMoviesData(event, at: index):
                    self?.processPopularMoviesDataEvent(event, at: index)
                }
            }
    }
    
    private func processPopularMoviesDataEvent(_ event: PopularMoviesCellData.Output, at index: Int) {
        switch event {
        case let .favoriteButton(event):
            switch event {
            case .changeState:
                let itemID = output.viewData.items[index].id
                logic.send(.changeFavStatus(id: itemID))
            }
        case .appeared:
            let itemID = output.viewData.items[index].id
            logic.send(.loadImage(for: itemID))
            if output.viewData.items.count - index <= Policy.refreshDistance {
                logic.send(.loadNextPage)
            }
        }
    }
    
    private func setSearchText(_ phrase: String) {
        var viewData = output.viewData
        viewData.searchText = phrase
        output.viewDataSubject.send(viewData)
    }
    
    private func showLoading(_ value: Bool) {
        var viewData = output.viewData
        viewData.isLoading = value
        output.viewDataSubject.send(viewData)
    }
}
