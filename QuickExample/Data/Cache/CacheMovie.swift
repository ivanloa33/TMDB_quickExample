//
//  CacheMovie.swift
//  QuickExample
//
//  Created by Ivan Lopez on 20/04/26.
//

import Foundation

struct CacheMovie {
    let id: Int
    let title: String
    let poster_path: String
    let releaseDate: Date
    let cachedA: Date
}

extension CacheMovie {
    func toDomain() -> Movie {
        .init(
            id: id,
            title: title,
            posterPath: poster_path,
            releaseDate: releaseDate)
    }
}
