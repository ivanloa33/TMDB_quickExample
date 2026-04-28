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
    let genres: [GenreDTO]
    let origin_country: [String]
    let original_language: String
    let overview: String
    let poster_path: String
    let release_date: String
    let runtime: Int
    let status: String
    let title: String
    let vote_average: Double
    
    func toDomain() -> MovieDetail {
        MovieDetail(
            id: id,
            backdropPath: backdrop_path,
            genres: genres.map { $0.toDomain() },
            originCountry: origin_country,
            originalLanguage: original_language,
            overview: overview,
            posterPath: poster_path,
            releaseDate: APIDateFormatter.yyyyMMdd.date(from: release_date) ?? Date(),
            runtime: runtime,
            status: status,
            title: title,
            voteAverage: vote_average
        )
    }
}

struct GenreDTO: Decodable {
    let id: Int
    let name: String
    
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }
}
