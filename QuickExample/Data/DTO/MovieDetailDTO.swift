//
//  MovieDetailDTO.swift
//  QuickExample
//
//  Created by Ivan Lopez on 25/04/26.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let id: Int
    let backdrop_path: String
    let origin_country: [String]
    let original_language: String
    let overview: String
    let release_date: String
    let runtime: Int
    let status: String
    let title: String
    
    func toDomain() -> MovieDetail {
        MovieDetail(
            id: id,
            backdropPath: backdrop_path,
            originCountry: origin_country,
            originalLanguage: original_language,
            overview: overview,
            releaseDate: APIDateFormatter.yyyyMMdd.date(from: release_date) ?? Date(),
            runtime: runtime,
            status: status,
            title: title
        )
    }
}
