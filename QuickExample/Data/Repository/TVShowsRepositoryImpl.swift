//
//  TVShowsRepositoryImpl.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

final class TVShowsRepositoryImpl: TVShowsRepository {
    
    private let httpClient: HTTPClient
    private let cache: any Cache<TVShowCategory, [TVShowDTO]>
    
    init(httpClient: HTTPClient,
         cache: any Cache<TVShowCategory, [TVShowDTO]>
    ) {
        self.httpClient = httpClient
        self.cache = cache
    }
    
    func fetchTVShows(category: TVShowCategory) async throws -> [TVShow] {
        let key = category
        
        if let cacheTVShows = await cache.get(key: key) {
            return cacheTVShows.map { $0.toDomain() }
        }
        
        let responseTVShowDTO: ResponseTVShowDTO = try await httpClient.get(endPoint: endpoint(category: category))
        
        await cache.set(responseTVShowDTO.results, for: key)
        
        return responseTVShowDTO.results.map { $0.toDomain() }
    }
    
    private func endpoint(category: TVShowCategory) -> TMDBEndPoint {
        switch category {
        case .onTheAir: return TMDBEndPoint.onTheAirTVShows
        case .popular: return TMDBEndPoint.popularTVShows
        case .topRated: return TMDBEndPoint.topRatedTVShows
        }
    }
}
