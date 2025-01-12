//
//  MovieDetailsApiRequest.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Combine

protocol MovieDetailsApiRequestable {
    static func getDetails(for movieID: Int) -> AnyPublisher<MovieDetailsResponse, ApiError>
    static func getSpokenLanguages(for movieID: Int) -> AnyPublisher<SpokenLanguageResponse, ApiError>
}

struct MovieDetailsApiRequest: MovieDetailsApiRequestable {
    static func getDetails(for movieID: Int) -> AnyPublisher<MovieDetailsResponse, ApiError> {
        let data = TMDBApiRequest.RequestData(
            endpointPath: "/movie/\(movieID)"
        )
        
        return TMDBApi.makeRequest(with: data)
    }
    
    static func getSpokenLanguages(for movieID: Int) -> AnyPublisher<SpokenLanguageResponse, ApiError> {
        let data = TMDBApiRequest.RequestData(
            endpointPath: "/movie/\(movieID)"
        )
        
        return TMDBApi.makeRequest(with: data)
    }
}
