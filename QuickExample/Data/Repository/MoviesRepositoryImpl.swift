//
//  MoviesRepositoryImpl.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

final class MoviesRepositoryImpl: MoviesRepository {
    
    private let httpClient: HTTPClient
    private let cache: any Cache<CacheKey, [CacheMovie]> = InMemoryCache()
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        if let movies = await fetchCachePopularMovies() {
            return movies
        }
        
        let movies = try await fetchRemotePopularMovies()
        
        await saveMoviesToCache(movies: movies)
        
        return movies
    }
    
    private func fetchRemotePopularMovies() async throws -> [Movie] {
        let responseMovieDTO: ResponseMovieDTO = try await httpClient.get(endPoint: TMDBEndPoint.popular)
        return responseMovieDTO.results.map { $0.toDomain() }
    }
    
    private func fetchCachePopularMovies() async -> [Movie]? {
        guard let cacheMovies = await cache.get(key: .popular) else {
            return nil
        }
        return cacheMovies.map { $0.toDomain() }
    }
    
    private func saveMoviesToCache(movies: [Movie]) async {
        let cacheMovies = movies.map { $0.toCache() }
        await cache.set(cacheMovies, for: .popular)
    }
}
