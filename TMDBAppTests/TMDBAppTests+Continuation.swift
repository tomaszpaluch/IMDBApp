//
//  TMDBAppTests+Continuation.swift
//  TMDBAppTests
//
//  Created by Tomasz Paluch on 14/01/2025.
//

import Testing
import Foundation
import Combine

protocol Testable { }

extension Testable {
    func continuation<T, K: Error>(
        for publisher: AnyPublisher<T, K>,
        debounceTime: DispatchQueue.SchedulerTimeType.Stride = 0
    ) async throws -> T  {
        try await withCheckedThrowingContinuation { continuation in
            var subsciption: AnyCancellable?
            subsciption = publisher
                .debounce(for: 0.05 + debounceTime, scheduler: DispatchQueue.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        continuation.resume(throwing: error)
                    }
                } receiveValue: { value in
                    continuation.resume(returning: value)
                    subsciption?.cancel()
                }
        }
    }
    
    func execute<T, K>(_ publisher: AnyPublisher<T, K>) throws -> T {
        var subscriptions: Set<AnyCancellable> = []

        var outputValue: T!
        var outputError: K?
        
        publisher
            .sink { completion in
                if case let .failure(error) = completion {
                    outputError = error
                }
            } receiveValue: { value in
                outputValue = value
            }
            .store(in: &subscriptions)
        
        if let outputError {
            throw outputError
        } else {
            return outputValue
        }
    }
}

