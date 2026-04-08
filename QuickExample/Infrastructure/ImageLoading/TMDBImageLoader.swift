//
//  ImageLoader.swift
//  QuickExample
//
//  Created by Ivan Lopez on 26/01/26.
//

import UIKit

enum ImageLoadingError: Error {
    case invalidImageData
}

protocol ImageLoading {
    func loadImage(from posterPath: String) async throws -> UIImage
}

actor TMDBImageLoader: ImageLoading {
    private let commonHeaders = ["Authorization": "Bearer \(Secrets.tmdbApiKey)"]
    
    private var cache: [String: UIImage] = [:]
    private var inFlightTasks: [String: Task<UIImage, Error>] = [:]
    
    func loadImage(from posterPath: String) async throws -> UIImage {
        if let cached = cache[posterPath]  {
            return cached
        }
        
        if let existingTask = inFlightTasks[posterPath] {
            return try await existingTask.value
        }
        
        let task = Task<UIImage, Error> {
            let request = try await ImageRequestBuilder.makeRequest(
                baseURL: .imageBaseUrl,
                endpoint: .poster(path: posterPath, size: .w500),
                headers: commonHeaders
            )
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let image = UIImage(data: data) else {
                throw ImageLoadingError.invalidImageData
            }
            return image
        }
        
        inFlightTasks[posterPath] = task
        
        do {
            let image = try await task.value
            cache[posterPath] = image
            inFlightTasks[posterPath] = nil
            return image
        } catch {
            inFlightTasks[posterPath] = nil
            throw error
        }
    }
}
