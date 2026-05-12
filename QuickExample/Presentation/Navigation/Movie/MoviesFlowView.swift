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
    @State private var path: [MovieRoute] = []
    @State private var selectedMovieDetail: MediaItemDetailRoute?
    
    var body: some View {
        NavigationStack(path: $path) {
            container.movies.makeMovieHomeView(
                onCategoryTap: handleOnCategoryTap,
                onMovieTap: handleOnMovieTap
            )
            .sheet(item: $selectedMovieDetail) { route in
                container.movies.makeMovieDetailView(from: route.id)
            }
            .navigationDestination(for: MovieRoute.self) { route in
                switch route {
                case .movieList(let category):
                    container.movies.makeMovieListView(category, onMovieTap: handleOnMovieTap)
                }
            }
            .navigationTitle("Movies")
        }
    }
    
    private func handleOnCategoryTap(categoryRawValue: String) {
        if let category = MovieCategory(rawValue: categoryRawValue) {
            path.append(.movieList(category: category))
        }
    }
    
    private func handleOnMovieTap(movieId: Int) {
        selectedMovieDetail = MediaItemDetailRoute(id: movieId)
    }
}
