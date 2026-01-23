//
//  FetchImageUseCase.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

protocol FetchImageUseCase {
    func execute(with posterPath: String) async throws -> Data
}

final class FetchImageUseCaseImpl: FetchImageUseCase {
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository = MoviesRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(with posterPath: String) async throws -> Data {
        do {
            let urlString = "\(Constants.Image.baseUrl)\(posterPath)"
            return try await repository.fetchPosterImage(from: urlString)
        } catch {
            print(error)
            throw error
            
        }
    }
}
