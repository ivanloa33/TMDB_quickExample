//
//  MoviesRepository.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

protocol MoviesRepository {
    func fetchPopularMovies() async throws -> [Movie]
    func fetchPosterImage(from posterPath: String) async throws -> Data
}
