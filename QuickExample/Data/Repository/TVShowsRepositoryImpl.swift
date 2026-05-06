//
//  TVShowsRepositoryImpl.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

final class TVShowsRepositoryImpl: TVShowsRepository {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchTVShows(category: TVShowCategory) async throws -> [TVShow] {
        let responseTVShowDTO: ResponseTVShowDTO = try await httpClient.get(endPoint: endpoint(category: category))
        
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
