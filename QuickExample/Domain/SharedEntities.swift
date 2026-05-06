//
//  SharedEntities.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

protocol MediaItem {
    var id: Int { get }
    var releaseDateText: String { get }
    var titleText: String { get }
    var posterPath: String { get }
}
