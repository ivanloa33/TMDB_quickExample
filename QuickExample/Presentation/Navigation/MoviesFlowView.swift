//
//  MoviesFlowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

private struct AppContainerKey: EnvironmentKey {
    // TODO: Create MockAppContainer / CoreContainer
    static let defaultValue: AppContainer = AppContainer()
}

extension EnvironmentValues {
    var container: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}

struct MoviesFlowView: View {
    @Environment(\.container) private var container: AppContainer
    @State private var selectedMovieDetail: MovieDetailRoute?
    
    var body: some View {
        NavigationStack {
            container.movies.makeHomeView(onMovieTap: handleOnMovieTap)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case let .movieList(category: categoryTitle):
                        if let category = MovieCategory(rawValue: categoryTitle) {
                            container.movies.makeMovieListView(category, onMovieTap: handleOnMovieTap)
                        }
                    }
                }
                .sheet(item: $selectedMovieDetail) { route in
                    container.movies.makeMovieDetailView(from: route.id)
                }
                .navigationTitle("Movies")
        }
    }
    
    private func handleOnMovieTap(movieId: Int) {
        selectedMovieDetail = MovieDetailRoute(id: movieId)
    }
}
