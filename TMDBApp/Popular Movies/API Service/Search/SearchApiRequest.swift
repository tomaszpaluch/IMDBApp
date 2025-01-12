//
//  SearchApiService.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Foundation
import Combine

protocol SearchApiRequestable {
    static func getMovies(with query: String, for page: Int) -> AnyPublisher<PaginatedResponse<PopularMoviesResponse>, ApiError>
}

struct SearchApiRequest: SearchApiRequestable {
    static func getMovies(with query: String, for page: Int) -> AnyPublisher<PaginatedResponse<PopularMoviesResponse>, ApiError> {
        let data = TMDBApiRequest.RequestData(
            method: .get,
            endpointPath: "/search/movie",
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
            ]
        )
        
        return TMDBApi.makeRequest(with: data)
    }
}
