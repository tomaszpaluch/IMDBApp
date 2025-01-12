//
//  PopularMoviesPagination.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

import Combine

protocol PopularMoviesPaginationable {
    var events: AnyPublisher<PopularMoviesPagination.Output, ApiError> { get }
    
    init(service: PopularMoviesApiServiceable)
    func loadNextPage()
    func reset()
}

class PopularMoviesPagination: PopularMoviesPaginationable {
    enum Output {
        case data([PopularMoviesCellData])
    }
    
    private let service: PopularMoviesApiServiceable
    
    private var nextPage: Int
    private var hasMorePages: Bool
    private var isProcessing: Bool { subscription != nil }
    
    private let eventRelay: PassthroughSubject<Output, ApiError>
    var events: AnyPublisher<Output, ApiError> { eventRelay.eraseToAnyPublisher() }
    private var subscription: AnyCancellable?
    
    required init(service: PopularMoviesApiServiceable) {
        self.service = service
        nextPage = 1
        hasMorePages = true
        
        eventRelay = .init()
    }
    
    func loadNextPage() {
        print(isProcessing, hasMorePages)
        if !isProcessing, hasMorePages {
            subscription = service.getMovies(for: nextPage)
                .sink { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.eventRelay.send(completion: .failure(error))
                    }
                    self?.finalizePageLoading()
                } receiveValue: { [weak self] (items, totalPageCount) in
                    self?.finalizePageLoading(items: items, totalPageCount: totalPageCount)
                }
        }
    }
    
    func finalizePageLoading() {
        nextPage += 1
        subscription = nil
    }
    
    func finalizePageLoading(items: [PopularMoviesCellData], totalPageCount: Int) {
        eventRelay.send(.data(items))
        hasMorePages = totalPageCount != nextPage
    }
    
    func reset() {
        nextPage = 1
        hasMorePages = true
        subscription = nil
    }
}
