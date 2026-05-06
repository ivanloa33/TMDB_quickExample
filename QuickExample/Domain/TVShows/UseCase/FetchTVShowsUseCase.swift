//
//  FetchTVShowsUseCase.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

protocol FetchTVShowsUseCase {
    func execute(category: TVShowCategory) async throws -> [TVShow]
}

final class FetchTVShowsUseCaseImpl: FetchTVShowsUseCase {
    
    private let repository: TVShowsRepository
    
    init(repository: TVShowsRepository) {
        self.repository = repository
    }
    
    func execute(category: TVShowCategory) async throws -> [TVShow] {
        try await repository.fetchTVShows(category: category)
    }
}
