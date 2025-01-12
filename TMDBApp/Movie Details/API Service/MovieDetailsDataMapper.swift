//
//  MovieDetailsDataMapper.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

struct MovieDetailsData {
    let overview: String
    let releaseDate: String
    let spokenLanguages: [String]
}

struct MovieDetailsDataMapper {
    static func map(_ responses: (MovieDetailsResponse, SpokenLanguageResponse)) -> MovieDetailsData? {
        guard
            let firstMap = map(responses.0),
            let secondMap = map(responses.1)
        else { return nil }
        
        return MovieDetailsData(overview: firstMap.0, releaseDate: firstMap.1, spokenLanguages: secondMap)
    }
    
    static private func map(_ response: MovieDetailsResponse) -> (String, String)? {
        guard
            let overview = response.overview,
            let releaseDate = response.releaseDate
        else { return nil }
        
        return (overview, releaseDate)
    }
    
    static private func map(_ response: SpokenLanguageResponse) -> [String]? {
        response.spokenLanguages?.compactMap { $0.englishName }
    }
}
