//
//  FetchPopularMoviesUseCase.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

protocol FetchPopularMoviesUseCase {
    func execute() async throws -> [Movie]
}

final class FetchPopularMoviesUseCaseImpl: FetchPopularMoviesUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Movie] {
        try await repository.fetchPopularMovies()
    }
}
