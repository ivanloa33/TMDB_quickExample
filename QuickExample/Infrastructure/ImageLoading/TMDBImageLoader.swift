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
    
    func loadImage(from posterPath: String) async throws -> UIImage {
        if let cached = cache[posterPath]  {
            return cached
        }
        
        let request = try await ImageRequestBuilder.makeRequest(
            baseURL: .imageBaseUrl,
            endpoint: .poster(path: posterPath, size: .w500),
            headers: commonHeaders
        )
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let image = UIImage(data: data) else {
            throw ImageLoadingError.invalidImageData
        }
        
        cache[posterPath] = image
        return image
    }
}
