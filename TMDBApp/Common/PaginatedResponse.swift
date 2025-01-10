//
//  PaginatedResponse.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 10/01/2025.
//

struct PaginatedResponse<T: Decodable>: Decodable {
    let results: [T]?
    let totalResults: Int?
    let page: Int?
    let totalPages: Int?
}
