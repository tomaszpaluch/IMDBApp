//
//  PopularMoviesPaginationFactory.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

protocol PopularMoviesPaginationFactorable {
    func make(for searchPhrase: String?) -> PopularMoviesPaginationable
    func make() -> PopularMoviesPaginationable
}

struct PopularMoviesPaginationFactory<
    Paginationable: PopularMoviesPaginationable,
    Searchable: SearchAPIServiceable,
    Discoverable: DiscoverApiServiceable
>: PopularMoviesPaginationFactorable {
    func make() -> any PopularMoviesPaginationable {
        make(for: nil)
    }
    
    func make(for searchPhrase: String?) -> PopularMoviesPaginationable {
        switch searchPhrase {
        case let .some(phrase):
            Paginationable(service: Searchable(searchPhrase: phrase))
        case .none:
            Paginationable(service: Discoverable())
        }
    }
}
