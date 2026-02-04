//
//  URLSessionHTTPClient.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    let commonHeaders: [String: String] = {
        ["Authorization": "Bearer \(Secrets.tmdbApiKey)",
         "Accept": "application/json"]
    }()

    func get<T: Decodable>(endPoint: Endpoint) async throws -> T {
        do {
            let request = try URLRequestBuilder.makeRequest(baseURL: .baseUrl, endpoint: endPoint, headers: commonHeaders)
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
