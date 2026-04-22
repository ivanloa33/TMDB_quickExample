//
//  Movie+Display.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import Foundation

extension Movie {
    var releaseDateText: String {
        DisplayDateFormatter.medium.string(from: releaseDate)
    }
}
