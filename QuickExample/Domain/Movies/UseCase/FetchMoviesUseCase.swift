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
    private let releaseDatePolicy: MovieReleaseDatePolicy
    
    init(repository: MoviesRepository, releaseDatePolicy: MovieReleaseDatePolicy = .init(dateWindowPolicy: .init(pastMonths: 3))) {
        self.repository = repository
        self.releaseDatePolicy = releaseDatePolicy
    }
    
    func execute(category: MovieCategory) async throws -> [Movie] {
        let movies = try await repository.fetchMovies(category: category)
        
        switch category {
        case .upcoming:
            return releaseDatePolicy.filter(movies)
        case .popular, .topRated:
            return movies
        }
    }
}

