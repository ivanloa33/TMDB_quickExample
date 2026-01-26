//
//  URLSessionHTTPClient.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    
    func createURLRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Constants.Secrets.tmdbApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func get<T: Decodable>(url: URL) async throws -> T {
        let request = createURLRequest(with: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
