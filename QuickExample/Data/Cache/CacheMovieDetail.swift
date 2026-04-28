//
//  CacheMovieDetail.swift
//  QuickExample
//
//  Created by Ivan Lopez on 28/04/26.
//

import Foundation

struct CacheMovieDetail {
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
    let cachedA: Date
    
    init(movieDetail: MovieDetailDTO) {
        id = movieDetail.id
        backdrop_path = movieDetail.backdrop_path
        genres = movieDetail.genres
        origin_country = movieDetail.origin_country
        original_language = movieDetail.original_language
        overview = movieDetail.overview
        poster_path = movieDetail.poster_path
        release_date = movieDetail.release_date
        runtime = movieDetail.runtime
        status = movieDetail.status
        title = movieDetail.title
        vote_average = movieDetail.vote_average
        cachedA = Date()
    }
}

extension CacheMovieDetail {
    func toDomain() -> MovieDetail {
        .init(id: id,
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
