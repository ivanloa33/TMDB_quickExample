//
//  ImageLoader.swift
//  QuickExample
//
//  Created by Ivan Lopez on 26/01/26.
//

import UIKit

actor TMDBImageDataLoader: ImageDataLoading {
    private let commonHeaders = ["Authorization": "Bearer \(Secrets.tmdbApiKey)"]
    
    // NSCache provides thread-safe, memory-pressure-aware caching.
    // Keyed by posterPath.
    private let cache = NSCache<NSString, NSData>()
    
    // In-flight task de-duplication to avoid duplicate network requests.
    private var inFlightTasks: [String: Task<Data, Error>] = [:]
    
    func loadImage(from posterPath: String) async throws -> Data {
        let key = posterPath as NSString
        
        if let cached = cache.object(forKey: key) as Data? {
            return cached
        }
        
        if let existingTask = inFlightTasks[posterPath] {
            return try await existingTask.value
        }
        
        let task = Task<Data, Error> {
            let request = try await ImageRequestBuilder.makeRequest(
                baseURL: .imageBaseUrl,
                endpoint: .poster(path: posterPath, size: .w500),
                headers: commonHeaders
            )
            let (data, _) = try await URLSession.shared.data(for: request)
            // Validate non-empty data.
            guard !data.isEmpty else {
                throw ImageLoadingError.noData
            }
            return data
        }
        
        inFlightTasks[posterPath] = task
        
        do {
            let data = try await task.value
            // Use data.count as cost so totalCostLimit is meaningful.
            cache.setObject(data as NSData, forKey: key, cost: data.count)
            inFlightTasks[posterPath] = nil
            return data
        } catch {
            inFlightTasks[posterPath] = nil
            throw error
        }
    }
}

