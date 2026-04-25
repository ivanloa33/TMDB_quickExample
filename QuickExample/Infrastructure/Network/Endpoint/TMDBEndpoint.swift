//
//  TMDBEndpoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/01/26.
//

import Foundation

enum TMDBEndPoint: Endpoint {
    
    case popularMovies
    case upcomingMovies
    case topRatedMovies
    case movieDetail(Int)
    
    var path: String {
        switch self {
        case .popularMovies:
            return "movie/popular"
        case .upcomingMovies:
            return "movie/upcoming"
        case .topRatedMovies:
            return "movie/top_rated"
        case .movieDetail(let movieId):
            return "movie/\(movieId)"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
}
