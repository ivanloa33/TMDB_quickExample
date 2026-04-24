//
//  RootView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct RootView: View {
    let container: AppContainer
    @State private var selectedMovieDetail: MovieDetailRoute?
    
    var body: some View {
        NavigationStack {
            container.makeHomeView(onMovieTap: handleOnMovieTap)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case let .movieList(category: category):
                        container.makeMovieListView(category, onMovieTap: handleOnMovieTap)
                    }
                }
                .sheet(item: $selectedMovieDetail) { route in
                    container.makeMovieDetailView(from: route.id)
                }
                .navigationTitle("Movies")
        }
    }
    
    private func handleOnMovieTap(movieId: Int) {
        selectedMovieDetail = MovieDetailRoute(id: movieId)
    }
}
