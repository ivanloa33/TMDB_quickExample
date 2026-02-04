//
//  TMDBImageEndpoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 04/02/26.
//

import Foundation

enum TMDBImageEndpoint {
    case poster(path: String, size: ImageSize)

    enum ImageSize: String {
        case w500, original
    }

    var path: String {
        switch self {
        case let .poster(rawPath, size):
            let cleanPath = rawPath.hasPrefix("/")
            ? rawPath
            : "/" + rawPath
            return "/\(size.rawValue)\(cleanPath)"
        }
    }
}
