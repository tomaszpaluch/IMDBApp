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
    
    private let logic: PopularMoviesLogic
    
    let output: Output
    private var subscriptions: Set<AnyCancellable>
    private var viewDataSubscription: AnyCancellable?
    
    init(popularMoviesPagination: PopularMoviesPaginationable) {
        self.logic = PopularMoviesLogic(popularMoviesPagination: popularMoviesPagination)
        
        output = Output()
        subscriptions = []
        
        setupBinding()
        loadData()
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
        viewData.isLoading = false
        viewData.errorMessage = message
        output.viewDataSubject.send(viewData)
    }
    
    private func proceedLogicEvent(_ event: PopularMoviesLogic.Output) {
        switch event {
        case let .changeFavStatus(value):
            changeFavStatus(value)
        case let .addData(items):
            addData(items)
        case let .showData(items):
            setData(items)
        }
    }
    
    private func changeFavStatus(_ value: Bool) {
        var viewData = output.viewData
        viewData.favoriteButtonData.isFavorite.toggle()
        output.viewDataSubject.send(viewData)
    }
    
    private func addData(_ items: [PopularMoviesCellData]) {
        let items = output.viewData.items + items
        setData(items)
    }
    
    private func setData(_ items: [PopularMoviesCellData]) {
        let viewData = PopularMoviesViewData(
            favoriteButtonData: output.viewData.favoriteButtonData,
            isLoading: false,
            items: items
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
            if output.viewData.items.count - index <= Policy.refreshDistance {
                logic.send(.loadNextPage)
            }
        }
    }
    
    private func loadData() {
        showLoading()
        logic.send(.loadNextPage)
    }
    
    private func showLoading() {
        var viewData = output.viewData
        viewData.isLoading = true
        output.viewDataSubject.send(viewData)
    }
}
