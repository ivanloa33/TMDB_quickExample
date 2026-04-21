//
//  TMDBEndpoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/01/26.
//

import Foundation

enum TMDBEndPoint: Endpoint {
    
    case popular
    case upcoming
    case topRated
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .upcoming:
            return "movie/upcoming"
        case .topRated:
            return "movie/top-rated"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
}
