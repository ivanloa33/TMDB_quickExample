//
//  URLSessionHTTPClient.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    
    func get<T: Decodable>(endPoint: EndPoint) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(for: endPoint.urlRequest)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
