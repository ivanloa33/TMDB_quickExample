//
//  URLRequestBuilder.swift
//  QuickExample
//
//  Created by Ivan Lopez on 28/01/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
}

struct URLRequestBuilder {
    static func makeRequest(
        baseURL: URL,
        endpoint: Endpoint,
        headers: [String: String]
    ) throws -> URLRequest {

        guard var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        let endpointPath = endpoint.path.hasPrefix("/")
            ? endpoint.path
            : "/" + endpoint.path

        components.path += endpointPath
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = headers
        return request
    }
}
