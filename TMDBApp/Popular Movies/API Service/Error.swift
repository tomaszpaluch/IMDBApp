//
//  Error.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 09/01/2025.
//

import Foundation

enum ApiError: Error {
    case unknownError
    case badURL
    case dataTaskFailure(URLError)
    case failureDuringDecoding(Error)
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            Texts.ApiErrors.unknownError
        case .badURL:
            Texts.ApiErrors.badURL
        case let .dataTaskFailure(error):
            "\(Texts.ApiErrors.dataTaskFailure). \(error.localizedDescription)"
        case let .failureDuringDecoding(error):
            "\(Texts.ApiErrors.failureDuringDecoding). \(error.localizedDescription)"
        }
    }
}
