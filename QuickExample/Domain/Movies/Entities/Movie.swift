//
//  Movie.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: Date
}

extension Movie {
    func toCache() -> CacheMovie {
        .init(
            id: id,
            title: title,
            poster_path: posterPath,
            overview: overview,
            releaseDate: releaseDate,
            cachedA: Date()
        )
    }
}
