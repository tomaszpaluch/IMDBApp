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
    
    private let popularMoviesPagination: PopularMoviesPaginationable
    
    let output: Output
    private var subscriptions: Set<AnyCancellable>
    private var viewDataSubscription: AnyCancellable?
    
    init(popularMoviesPagination: PopularMoviesPaginationable) {
        self.popularMoviesPagination = popularMoviesPagination
        
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
        
        popularMoviesPagination.events
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.showError(error.localizedDescription)
                }
            } receiveValue: { [weak self] event in
                if case let .data(items) = event {
                    self?.setData(items)
                }
            }
            .store(in: &subscriptions)
    }
    
    private func showError(_ message: String) {
        var viewData = output.viewData
        viewData.isLoading = false
        viewData.errorMessage = message
        output.viewDataSubject.send(viewData)
    }
    
    private func setData(_ items: [PopularMoviesData]) {
        let viewData = PopularMoviesViewData(
            favoriteButtonData: output.viewData.favoriteButtonData,
            isLoading: false,
            items: output.viewData.items + items
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
                    break
                case let .popularMoviesData(event, at: index):
                    self?.processPopularMoviesDataEvent(event, at: index)
                }
            }
    }
    
    private func processPopularMoviesDataEvent(_ event: PopularMoviesData.Output, at index: Int) {
        switch event {
        case .favoriteButton:
            break
        case .appeared:
            if output.viewData.items.count - index <= Policy.refreshDistance {
                popularMoviesPagination.loadNextPage()
            }
        }
    }
    
    private func loadData() {
        showLoading()
        popularMoviesPagination.loadNextPage()
    }
    
    private func showLoading() {
        var viewData = output.viewData
        viewData.isLoading = true
        output.viewDataSubject.send(viewData)
    }
}
