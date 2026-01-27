//
//  TMDBEndpoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/01/26.
//

import Foundation

enum TMDBEndPoint: EndPoint {
    
    case popular
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var headers: [String: String] {
        ["Bearer \(Secrets.tmdbApiKey)": "Authorization",
         "application/json": "Accept"]
    }
    
    var urlRequest: URLRequest {
        var urlrequest = URLRequest(url: URL(string: "\(APIConfig.baseUrl)/\(path)")!)
        urlrequest.httpMethod = method
        urlrequest.allHTTPHeaderFields = headers
        
        return urlrequest
    }
}
