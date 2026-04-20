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
    
    func toDomain() -> Movie {
        Movie(id: id, title: title, posterPath: poster_path, overview: overview)
    }
}
