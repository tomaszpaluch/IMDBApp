//
//  SpokenLanguageResponse.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 12/01/2025.
//

struct SpokenLanguageResponse: Decodable {
    struct SpokenLanguage: Decodable {
        let englishName: String?
        let iso_639_1: String?
        let name: String?
    }
    
    let spokenLanguages: [SpokenLanguage]?
}
