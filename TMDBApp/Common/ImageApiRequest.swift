//
//  ImageApiRequest.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

import Foundation
import Combine

struct ImageApiRequest {
    struct RequestData {
        let posterPath: String
    }
    
    typealias Output = (data: Data, response: URLResponse)
    
    private static let apiPath = "https://image.tmdb.org/t/p/"
    private static let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTM5ZjQyYTgyYmVjNGRhZTgyMTNmMjRkMzAzMGFjOCIsIm5iZiI6MTczNjUwNTQ0Ni4zNjUsInN1YiI6IjY3ODBmODY2YzVkMmU5NmUyNjdiMzliNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sTpMAgRgCAEXwzGiF4YwLp-ksOPqyMLGNEpYfvQ0C_0"
    
    static func makeRequest(with data: RequestData) -> AnyPublisher<Output, ApiError> {
        guard
            let endpointURL = URL(string: "\(apiPath)\(data.posterPath)")
        else {
            return Fail<Output, ApiError>(error: .badURL).eraseToAnyPublisher()
        }
                
        print(endpointURL)
        
        guard
            let url = URLComponents(url: endpointURL, resolvingAgainstBaseURL: true)?.url
        else {
            return Fail<Output, ApiError>(error: .badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(key)"
        ]
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { ApiError.dataTaskFailure($0) }
            .eraseToAnyPublisher()
    }
}
