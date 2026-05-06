//
//  TVShowCategory+Display.swift
//  QuickExample
//
//  Created by Ivan Lopez on 06/05/26.
//

import Foundation

extension TVShowCategory {
    var title: String {
        switch self {
        case .onTheAir: return "On The Air"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        }
    }
}
