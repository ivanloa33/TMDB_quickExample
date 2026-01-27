//
//  MoviesRepositoryImpl.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

final class MoviesRepositoryImpl: MoviesRepository {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        let responseMovieDTO: ResponseMovieDTO = try await httpClient.get(endPoint: TMDBEndPoint.popular)
        return responseMovieDTO.results.map { $0.toMovie() }
    }
}
