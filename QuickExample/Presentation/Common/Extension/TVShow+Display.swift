//
//  TVShow+Display.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

extension TVShow: MediaItem {
    var releaseDateText: String {
        DisplayDateFormatter.medium.string(from: firstAirDate)
    }
    
    var titleText: String {
        name
    }
}
