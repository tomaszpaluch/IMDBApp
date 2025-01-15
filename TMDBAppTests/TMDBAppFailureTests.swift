//
//  TMDBAppFailureTests.swift
//  TMDBAppTests
//
//  Created by Tomasz Paluch on 15/01/2025.
//

import Testing
import Foundation
import Combine
@testable import TMDBApp

struct TMDBAppFailureTests: Testable {
    typealias PopularMoviesPaginationFactoryMock = PopularMoviesPaginationFactory<PopularMoviesPagination, SearchAPIServiceFailureMock, DiscoverAPIServiceFailureMock>
    
    let viewModel: PopularMoviesViewModel
    
    init() {
        viewModel = PopularMoviesViewModel(
            logic: PopularMoviesLogic(
                popularMoviesPaginationFactory: PopularMoviesPaginationFactoryMock(),
                imageAPIService: ImageAPIServiceFake(),
                popularMoviesPersistence: nil
            )
        )
    }
    
    @Test func getItemsCount_ForFirstPage_Returns0() throws {
        let itemCount = viewModel.output.viewData.items.count
        #expect(itemCount == 0)
    }
    
    @Test func getErrorMessage_ForFirstPage_ThrowUnknownError() throws {
        let errorMessage = viewModel.output.viewData.errorMessage
        #expect(errorMessage == ApiError.unknownError.localizedDescription)
    }
    
    @Test func getItemsCount_SearchingForMoviesContainingBeta_Returns0() async throws {
        viewModel.output.viewData.send(.searchPhrase("Beta"))
        try await continuation(for: viewModel.objectWillChange.eraseToAnyPublisher(), debounceTime: 0.55)
        let itemCount = viewModel.output.viewData.items.count
        #expect(itemCount == 0)
    }
    
    @Test func getErrorMessage_SearchingForMoviesContainingBeta_ThrowUnknownError() async throws {
        viewModel.output.viewData.send(.searchPhrase("Beta"))
        try await continuation(for: viewModel.objectWillChange.eraseToAnyPublisher(), debounceTime: 0.55)
        let errorMessage = viewModel.output.viewData.errorMessage
        #expect(errorMessage == ApiError.unknownError.localizedDescription)
    }
}
