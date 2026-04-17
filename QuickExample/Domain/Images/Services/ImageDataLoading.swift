//
//  ImageDataLoading.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import Foundation

enum ImageLoadingError: Error {
    case noData
    case invalidData
}

protocol ImageDataLoading {
    func loadImage(from posterPath: String) async throws -> Data
}
