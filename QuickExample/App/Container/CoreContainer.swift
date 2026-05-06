//
//  CoreContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 04/05/26.
//

import Foundation

final class CoreContainer {
    let httpClient: HTTPClient
    let imageLoader: ImageLoading
    
    init(
        httpClient: HTTPClient = URLSessionHTTPClient(),
        imageLoader: ImageLoading? = nil
    ) {
        self.httpClient = httpClient
        self.imageLoader = imageLoader ?? DefaultImageLoader(dataLoader: TMDBImageDataLoader())
    }
}
