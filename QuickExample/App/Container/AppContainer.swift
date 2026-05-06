//
//  AppContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import SwiftUI

final class AppContainer {
    let movies: MoviesContainer
    let tvShows: TVShowsContainer
    
    init(coreContainer: CoreContainer = CoreContainer()) {
        self.movies = MoviesContainer(core: coreContainer)
        self.tvShows = TVShowsContainer(core: coreContainer)
    }
}
