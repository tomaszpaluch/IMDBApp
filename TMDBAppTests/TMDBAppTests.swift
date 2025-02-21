//
//  TMDBAppTests.swift
//  TMDBAppTests
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import Testing
import Foundation
import Combine
@testable import TMDBApp

struct TMDBAppTests: Testable {    
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
    
    @Test func getItemCount_ForFirstPage_Returns10() throws {
        let itemCount = viewModel.output.viewData.items.count
        #expect(itemCount == DiscoverAPIServiceMock.itemsPerPage)
    }
    
    @Test func getItemCount_LoadSecondPage_Returns20() throws {
        viewModel.output.viewData.items.last?.send(.appeared)
        let itemCount = viewModel.output.viewData.items.count
        #expect(itemCount == 2 * DiscoverAPIServiceMock.itemsPerPage)
    }
    
    @Test func getMovieIDAndTitle_FirstMovie_Returns1AndAlpha_1() throws {
        let firstItem = viewModel.output.viewData.items.first
        #expect(firstItem?.id == 1 && firstItem?.movieTitle == "Alpha 1")
    }
    
    @Test func changeFavoriteMoviesOnlyStatus_SetOnlyFavs_ReturnsTrue() throws {
        viewModel.output.viewData.favoriteButtonData.send(.changeState)
        
        #expect(viewModel.output.viewData.favoriteButtonData.isFavorite == true)
    }
    
    @Test func changeFavoriteMoviesOnlyStatus_RestoreOriginalStatus_ReturnsFalse() throws {
        viewModel.output.viewData.favoriteButtonData.send(.changeState)
        viewModel.output.viewData.favoriteButtonData.send(.changeState)

        #expect(viewModel.output.viewData.favoriteButtonData.isFavorite == false)
    }
    
    @Test func changeFavoriteMovieStatus_FirstMovie_ReturnsTrue() async throws {
        viewModel.output.viewData.items.first?.favoriteButtonData.send(.changeState)

        let item = viewModel.output.viewData.items.first
        #expect(item?.favoriteButtonData.isFavorite == true)
    }
    
    @Test func changeFavoriteMovieStatus_RestoreFirstMovieStatus_ReturnsFalse() async throws {
        viewModel.output.viewData.items.first?.favoriteButtonData.send(.changeState)
        viewModel.output.viewData.items.first?.favoriteButtonData.send(.changeState)

        let item = viewModel.output.viewData.items.first
        #expect(item?.favoriteButtonData.isFavorite == false)
    }
    
    @Test func setSearchText_ShowMoviesContainingBeta_ReturnsBeta() async throws {
        let searchText = "Beta"
        viewModel.output.viewData.send(.searchPhrase(searchText))
        try await continuation(for: viewModel.objectWillChange.eraseToAnyPublisher(), debounceTime: 0.55)

        #expect(viewModel.output.viewData.searchText == searchText)
    }
    
    @Test func getMovieCount_ShowMoviesContainingBeta_Returns5() async throws {
        let searchText = "Beta"
        viewModel.output.viewData.send(.searchPhrase(searchText))
        try await continuation(for: viewModel.objectWillChange.eraseToAnyPublisher(), debounceTime: 0.55)
        
        #expect(viewModel.output.viewData.items.count == 5)
    }
    
    @Test func getMovieTitle_GetFirstMovieContainingBeta_ReturnsBeta_1() async throws {
        let searchText = "Beta"
        viewModel.output.viewData.send(.searchPhrase(searchText))
        try await continuation(for: viewModel.objectWillChange.eraseToAnyPublisher(), debounceTime: 0.55)
        
        #expect(viewModel.output.viewData.items.first?.movieTitle == "\(searchText) 1")
    }
}


