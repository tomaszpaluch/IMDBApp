//
//  MovieDetailsApiService.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Combine

protocol MovieDetailsApiServiceable {
    func getDetails(for movieID: Int) -> AnyPublisher<MovieDetailsData, ApiError>
}

struct MovieDetailsApiService: MovieDetailsApiServiceable {
    func getDetails(for movieID: Int) -> AnyPublisher<MovieDetailsData, ApiError> {
        Publishers.Zip(
            MovieDetailsApiRequest.getDetails(for: movieID),
            MovieDetailsApiRequest.getSpokenLanguages(for: movieID)
        )
        .compactMap(MovieDetailsDataMapper.map)
        .eraseToAnyPublisher()
    }
}
