//
//  MovieDetailsResponse.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

struct MovieDetailsResponse: Decodable {
    struct Genre: Decodable {
        let id: Int?
        let name: String?
    }
    
    struct ProductionCompany: Decodable {
        let id: Int?
        let logoPath: String?
        let name: String?
        let originCountry: String?
    }
    
    struct ProductionCountry: Decodable {
        let iso_3166_1: String?
        let name: String?
    }
    
    struct SpokenLanguage: Decodable {
        let englishName: String?
        let iso_639_1: String?
        let name: String?
    }
    
    let adult: Bool?
    let backdropPath: String?
//    let belongsToCollection: [Any: Any]?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
