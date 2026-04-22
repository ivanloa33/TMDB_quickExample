//
//  FetchMoviesUseCase.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

protocol FetchMoviesUseCase {
    func execute(category: MovieCategory) async throws -> [Movie]
}

final class FetchMoviesUseCaseImpl: FetchMoviesUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func execute(category: MovieCategory) async throws -> [Movie] {
        try await repository.fetchMovies(category: category)
    }
}

