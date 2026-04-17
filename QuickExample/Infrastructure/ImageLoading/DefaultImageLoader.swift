//
//  DefaultImageLoader.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import UIKit.UIImage

protocol ImageLoading {
    func loadImage(from posterPath: String) async throws -> UIImage
}

struct DefaultImageLoader: ImageLoading {
    
    private let dataImageLoader: ImageDataLoading
    
    init(dataImageLoader: ImageDataLoading = TMDBImageDataLoader()) {
        self.dataImageLoader = dataImageLoader
    }
    
    func loadImage(from posterPath: String) async throws -> UIImage {
        do {
            let data = try await dataImageLoader.loadImage(from: posterPath)
            guard let image = UIImage(data: data) else {
                throw ImageLoadingError.invalidData
            }
            return image
        } catch {
            throw error
        }
    }
}
