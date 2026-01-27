//
//  ImageLoader.swift
//  QuickExample
//
//  Created by Ivan Lopez on 26/01/26.
//

import UIKit

protocol ImageLoading {
    func loadImage(from url: URL) async throws -> UIImage
}

actor TMDBImageLoader: ImageLoading {
    private var cache: [URL: UIImage] = [:]
    
    func loadImage(from url: URL) async throws -> UIImage {
        if let cached = cache[url]  {
            return cached
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.setValue("Bearer \(await Constants.Secrets.tmdbApiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let image = UIImage(data: data)!
        
        cache[url] = image
        return image
    }
}
