//
//  MovieDetail.swift
//  QuickExample
//
//  Created by Ivan Lopez on 25/04/26.
//

import Foundation

struct MovieDetail {
    let id: Int
    let backdropPath: String
    let genres: [Genre]
    let originCountry: [String]
    let originalLanguage: String
    let overview: String
    let posterPath: String
    let releaseDate: Date
    let runtime: Int
    let status: String
    let title: String
    let voteAverage: Double
}

struct Genre {
    let id: Int
    let name: String
}
