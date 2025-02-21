//
//  TMDBAppUITests.swift
//  TMDBAppUITests
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import XCTest
@testable import TMDBApp

final class TMDBAppUITests: XCTestCase {
    override func setUpWithError() throws {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["useMockData" : "true"]
        app.launch()
    }

    func test_SwipeUp_LoadNextPage() throws {
        guard
            let ninthButtonTitle = MockMovieTitles.titles[safe: 8],
            let eighteenthButtonTitle = MockMovieTitles.titles[safe: 17]
        else {
            XCTFail()
            return
        }
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.buttons[ninthButtonTitle].swipeUp(velocity: .fast)
        let button = collectionViewsQuery.buttons[eighteenthButtonTitle]
        XCTAssertTrue(button.exists)
    }
    
    func test_Search_LoadFilmNamed() throws {
        guard
            let firstButtonTitle = MockMovieTitles.titles[safe: 0],
            let sixthButtonTitle = MockMovieTitles.titles[safe: 5]
        else {
            XCTFail()
            return
        }
        
        let app = XCUIApplication()
        let lookForAMovieSearchField = app.navigationBars[Texts.PopularMovies.title].searchFields[Texts.PopularMovies.searchPrompt]
        let button = app.collectionViews.buttons[firstButtonTitle]
        let _ = button.waitForExistence(timeout: 1)
        XCTAssertTrue(lookForAMovieSearchField.exists)
        
        lookForAMovieSearchField.tap()
        lookForAMovieSearchField.typeText(sixthButtonTitle)

        let resultButton = app.collectionViews.buttons[sixthButtonTitle]
        let resultButtonExists = resultButton.waitForExistence(timeout: 1)
        XCTAssertTrue(resultButtonExists)
    }
    
    func test_Favouries_AddFilmToFavourites() throws {
        let app = XCUIApplication()

        guard
            let buttonName = MockMovieTitles.titles[safe: 4]
        else {
            XCTFail()
            return
        }
        
        let element = app.collectionViews.buttons[buttonName]
        element.buttons[AccessibilityIdentifiers.PopularMovies.favouriteButton].tap()
        
        XCTAssertTrue(app.navigationBars[Texts.PopularMovies.title].exists)

        app.navigationBars[Texts.PopularMovies.title].buttons[AccessibilityIdentifiers.PopularMovies.favouriteButton].tap()
        let collectionViewsQuery = XCUIApplication().collectionViews
        let button = collectionViewsQuery.buttons[buttonName]
        XCTAssertTrue(button.exists)
    }
}
