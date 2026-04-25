//
//  FetchMovieDetailUseCase.swift
//  QuickExample
//
//  Created by Ivan Lopez on 25/04/26.
//

import Foundation

protocol FetchMovieDetailUseCase {
    func execute(movieId: Int) async throws -> MovieDetail
}

final class FetchMovieDetailUseCaseImpl: FetchMovieDetailUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func execute(movieId: Int) async throws -> MovieDetail {
        try await repository.fetchMovieDetail(movieId: movieId)
    }
}
