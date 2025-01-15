//
//  ImagesApiRequestable.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Foundation
import Combine

protocol ImageAPIServiceable {
    static func getImage(path: String, withSize: ImageAPIService.Size) -> AnyPublisher<Data, ApiError>
}

struct ImageAPIService: ImageAPIServiceable {
    enum Size: String {
        case original
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
    }
    
    static func getImage(path: String, withSize size: Size = .original) -> AnyPublisher<Data, ApiError> {
        let data = ImageApiRequest.RequestData(
            posterPath: "\(size.rawValue)\(path)"
        )
        
        return ImageApiRequest
            .makeRequest(with: data)
            .map { response in
                response.data
            }
            .eraseToAnyPublisher()
    }
}
