//
//  ImageRequestBuilder.swift
//  QuickExample
//
//  Created by Ivan Lopez on 04/02/26.
//

import Foundation

struct ImageRequestBuilder {
    static func makeRequest(
        baseURL: URL,
        endpoint: TMDBImageEndpoint,
        headers: [String: String]
    ) throws -> URLRequest {

        guard var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        components.path += endpoint.path

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.allHTTPHeaderFields = headers

        return request
    }
}
