//
//  MoviesRepositoryImpl.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

final class MoviesRepositoryImpl: MoviesRepository {
    
    private let httpClient: HTTPClient
    private let cache: any Cache<CacheKey, [CacheMovie]>
    
    init(httpClient: HTTPClient,
         cache: any Cache<CacheKey, [CacheMovie]>) {
        self.httpClient = httpClient
        self.cache = cache
    }
    
    func fetchMovies(category: MovieCategory) async throws -> [Movie] {
        let key = cacheKey(category: category)
        
        if let cacheMovies = await cache.get(key: key) {
            return cacheMovies.map { $0.toDomain() }
        }
        
        let responseMovieDTO: ResponseMovieDTO = try await httpClient.get(endPoint: endpoint(category: category))
        
        await cache.set(responseMovieDTO.results.map { $0.toCache() }, for: key)
        
        return responseMovieDTO.results.map { $0.toDomain() }
    }
    
    private func endpoint(category: MovieCategory) -> TMDBEndPoint {
        switch category {
        case .popular: return .popular
        case .upcoming: return .upcoming
        case .topRated: return .topRated
        }
    }
    
    private func cacheKey(category: MovieCategory) -> CacheKey {
        switch category {
        case .popular: return .popular
        case .upcoming: return .upcoming
        case .topRated: return .topRated
        }
    }
}
