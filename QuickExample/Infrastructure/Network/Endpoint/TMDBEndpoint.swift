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
    case onTheAirTVShows
    case popularTVShows
    case topRatedTVShows
    
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
        case .onTheAirTVShows:
            return "tv/on_the_air"
        case .popularTVShows:
            return "tv/popular"
        case .topRatedTVShows:
            return "tv/top_rated"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
}
