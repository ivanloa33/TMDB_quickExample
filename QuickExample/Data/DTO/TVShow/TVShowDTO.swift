//
//  TVShowDTO.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

struct TVShowDTO: Decodable {
    let first_air_date: String
    let id: Int
    let name: String
    let poster_path: String
    
    func toDomain() -> TVShow {
        TVShow(
            firstAirDate: APIDateFormatter.yyyyMMdd.date(from: first_air_date) ?? Date(),
            id: id,
            name: name,
            posterPath: poster_path)
    }
}
