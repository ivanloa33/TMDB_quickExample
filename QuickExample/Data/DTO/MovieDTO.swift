//
//  MovieDTO.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let poster_path: String
    let overview: String
    let releaseDate: String
    
    func toDomain() -> Movie {
        Movie(
            id: id,
            title: title,
            posterPath: poster_path,
            overview: overview,
            releaseDate: APIDateFormatter.yyyyMMdd.date(from: releaseDate) ?? Date()
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id,title, poster_path, overview
        case releaseDate = "release_date"
    }
}
