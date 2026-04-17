//
//  DefaultImageLoader.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import UIKit.UIImage

struct DefaultImageLoader: ImageLoading {
    
    private let dataLoader: ImageDataLoading
    
    init(dataLoader: ImageDataLoading) {
        self.dataLoader = dataLoader
    }
    
    func loadImage(from posterPath: String) async throws -> UIImage {
        do {
            let data = try await dataLoader.loadImage(from: posterPath)
            guard let image = UIImage(data: data) else {
                throw ImageLoadingError.invalidData
            }
            return image
        } catch {
            throw error
        }
    }
}
