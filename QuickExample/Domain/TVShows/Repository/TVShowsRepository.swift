//
//  TVShowsRepository.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import Foundation

protocol TVShowsRepository {
    func fetchTVShows(category: TVShowCategory) async throws -> [TVShow]
}
