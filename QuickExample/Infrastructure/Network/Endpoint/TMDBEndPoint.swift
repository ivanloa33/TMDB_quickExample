//
//  TMDBEndpoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/01/26.
//

import Foundation

enum TMDBEndPoint: EndPoint {
    
    case popular
    case imagePosterPath(String)
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .imagePosterPath(let path):
            return path
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
        var baseURL: String
        switch self {
        case .imagePosterPath:
            baseURL = "\(APIConfig.imageBaseUrl)/"
        default:
            baseURL = "\(APIConfig.baseUrl)/"
        }
        
        var urlrequest = URLRequest(url: URL(string: "\(baseURL)\(path)")!)
        urlrequest.httpMethod = method
        urlrequest.allHTTPHeaderFields = headers
        
        return urlrequest
    }
}
