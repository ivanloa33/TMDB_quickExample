//
//  ResponseMovieDTO.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

struct ResponseMovieDTO: Decodable {
    let page: Int
    let results: [MovieDTO]
}
