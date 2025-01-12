//
//  MovieDetailsViewModel.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Combine

class MovieDetailsViewModel: ObservableObject {
    struct Output {
        fileprivate let viewDataSubject: CurrentValueSubject<MovieDetailsViewData, Never>
        fileprivate var viewDataPublisher: AnyPublisher<MovieDetailsViewData, Never> {
            viewDataSubject.eraseToAnyPublisher()
        }
        var viewData: MovieDetailsViewData { viewDataSubject.value }
        
        init(initialData: MovieDetailsViewData) {
            viewDataSubject = .init(initialData)
        }
    }
    
    private let apiService: MovieDetailsApiServiceable
    
    let output: Output
    
    private var subscriptions: Set<AnyCancellable>
    
    init(apiService: MovieDetailsApiServiceable, initialData: MovieDetailsViewData) {
        self.apiService = apiService
        
        output = Output(
            initialData: initialData
        )
        
        subscriptions = []
        
        setupBinding()
        loadAdditionalData()
    }
    
    private func setupBinding() {
        output.viewDataPublisher
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &subscriptions)
        
        output.viewData.events
            .sink { [weak self] event in
                switch event {
                case let .favoriteButton(output):
                    switch output {
                    case .changeState:
                        self?.proceedFavStatusChange()
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
    private func proceedFavStatusChange() {
        var viewData = output.viewData
        viewData.favoriteButtonData.isFavorite.toggle()
        output.viewDataSubject.send(viewData)
    }
    
    private func loadAdditionalData() {
        showLoading(true)

        var subscription: AnyCancellable?
        subscription = apiService.getDetails(for: output.viewData.id)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.showError(error.localizedDescription)
                }
                _ = subscription.map { self?.subscriptions.remove($0) }
                self?.showLoading(false)
            } receiveValue: { [weak self] data in
                self?.setAdditionalDetailsData(data)
            }
    }
    
    private func showError(_ message: String) {
        var viewData = output.viewData
        viewData.errorMessage = message
        output.viewDataSubject.send(viewData)
    }
    
    private func showLoading(_ value: Bool) {
        var viewData = output.viewData
        viewData.isLoading = value
        output.viewDataSubject.send(viewData)
    }
    
    private func setAdditionalDetailsData(_ data: MovieDetailsData) {
        var viewData = output.viewData
        viewData.overview = data.overview
        viewData.releaseDate = data.releaseDate
        viewData.spokenLanguages = data.spokenLanguages
        output.viewDataSubject.send(viewData)
    }
}
