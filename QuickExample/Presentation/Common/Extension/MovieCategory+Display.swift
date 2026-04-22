//
//  MovieCategory+Display.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import Foundation

extension MovieCategory {
    var title: String {
        switch self {
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        }
    }
}
