//
//  DiscoverApiService.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

import Foundation
import Combine

protocol DiscoverApiServiceable {
    static func getMovies(for page: Int) -> AnyPublisher<PaginatedResponse<PopularMoviesResponse>, ApiError>
}

struct DiscoverApiService: DiscoverApiServiceable {
    static func getMovies(for page: Int) -> AnyPublisher<PaginatedResponse<PopularMoviesResponse>, ApiError> {
        let data = TMDBApiRequest.RequestData(
            method: .get,
            endpointPath: "/discover/movie",
            queryItems: [
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "include_video", value: "false"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
            ]
        )
        
        return TMDBApi.makeRequest(with: data)
    }
}
