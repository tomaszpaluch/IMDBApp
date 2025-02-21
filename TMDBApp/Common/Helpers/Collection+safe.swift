//
//  Collection+safe.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 21/02/2025.
//

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
