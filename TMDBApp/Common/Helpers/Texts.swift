//
//  Texts.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

struct Texts {
    struct Common {
        static let ok = "OK"
    }
    
    struct ApiErrors {
        static let title = "Wystąpił błąd"
        static let unknownError = "An unknown error occured"
        static let badURL = "An bad url error occured"
        static let dataTaskFailure = "An data task error occured"
        static let failureDuringDecoding = "An error during data decoding occured"
    }
    
    struct PopularMovies {
        static let title = "Popular Movies"
        static let searchPrompt = "Look for a movie"
    }
    
    struct MovieDetails {
        static let releaseDate = "Release date"
        static let showSpokenLanguages = "Show spoken languages"
    }
}
