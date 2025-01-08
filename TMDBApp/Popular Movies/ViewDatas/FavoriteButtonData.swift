//
//  FavoriteButtonData.swift
//  TMDBApp
//
//  Created by Tomasz Paluch on 08/01/2025.
//

import Combine

struct FavoriteButtonData {
    static let initial: Self = .init(isFavorite: false)
    
    enum Output {
        case changeState
    }
    
    let isFavorite: Bool
    
    private let eventRelay: PassthroughSubject<Output, Never>
    var events: AnyPublisher<Output, Never> { eventRelay.eraseToAnyPublisher() }
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
        self.eventRelay = .init()
    }
    
    func send(_ output: Output) {
        eventRelay.send(output)
    }
}
