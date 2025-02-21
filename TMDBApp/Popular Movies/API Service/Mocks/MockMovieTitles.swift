//
//  MockMovieTitles.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 21/02/2025.
//

struct MockMovieTitles {
    static let titles: [String] = {
        ["Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota", "Upsilon", "Omega"]
            .reduce([]) { result, element in
                var updatedResult = result
                updatedResult.append(contentsOf: (1...5).map { "\(element) \($0)" })
                return updatedResult
            }
    }()
}
