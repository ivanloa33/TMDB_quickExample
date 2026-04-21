//
//  MoviesRepository.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

protocol MoviesRepository {
    func fetchMovies(category: MovieCategory) async throws -> [Movie]
}
