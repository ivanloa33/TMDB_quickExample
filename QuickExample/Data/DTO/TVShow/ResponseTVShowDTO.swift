//
//  ResponseTVShowDTO.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

struct ResponseTVShowDTO: Decodable {
    let page: Int
    let results: [TVShowDTO]
}
