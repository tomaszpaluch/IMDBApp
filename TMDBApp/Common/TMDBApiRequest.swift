//
//  TMDBApiRequest.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

import Foundation
import Combine

struct TMDBApiRequest {
    struct RequestData {
        enum Method: String {
            case get = "GET"
        }
        
        let method: Method
        let endpointPath: String
        let queryItems: [URLQueryItem]
    }
    
    typealias Output = (data: Data, response: URLResponse)
    
    private static let apiPath = "https://api.themoviedb.org/3/"
    private static let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTM5ZjQyYTgyYmVjNGRhZTgyMTNmMjRkMzAzMGFjOCIsIm5iZiI6MTczNjUwNTQ0Ni4zNjUsInN1YiI6IjY3ODBmODY2YzVkMmU5NmUyNjdiMzliNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sTpMAgRgCAEXwzGiF4YwLp-ksOPqyMLGNEpYfvQ0C_0"
    
    static func makeRequest(with data: RequestData) -> AnyPublisher<Output, ApiError> {
        guard
            let endpointURL = URL(string: "\(apiPath)\(data.endpointPath)")
        else {
            return Fail<Output, ApiError>(error: .badURL).eraseToAnyPublisher()
        }
        
        var components = URLComponents(url: endpointURL, resolvingAgainstBaseURL: true)
        components?.queryItems = data.queryItems
        
        guard
            let url = components?.url
        else {
            return Fail<Output, ApiError>(error: .badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = data.method.rawValue
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
