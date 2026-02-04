//
//  TMDBEndpoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/01/26.
//

import Foundation

enum TMDBEndPoint: Endpoint {
    
    case popular
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"        }
    }
    
    var method: String {
        "GET"
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
}
