//
//  TMDBApi.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

import Foundation
import Combine

struct TMDBApi<T: Decodable> {
    static func makeRequest(with data: TMDBApiRequest.RequestData) -> AnyPublisher<T, ApiError> {
        TMDBApiRequest.makeRequest(with: data)
            .tryMap { data in
                do {
                    return try Self.decodeData(data.data)
                } catch {
                    throw ApiError.failureDuringDecoding(error)
                }
            }
            .mapError {
                if let error = $0 as? ApiError {
                    error
                } else {
                    ApiError.unknownError
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private static func decodeData(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            print(error)
            throw error
        }
    }
}
