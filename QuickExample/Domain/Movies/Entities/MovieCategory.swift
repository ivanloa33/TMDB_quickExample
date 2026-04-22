//
//  MovieCategory.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import Foundation

enum MovieCategory: String {
    case popular
    case upcoming
    case topRated
    
    var title: String {
        switch self {
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        }
    }
}
