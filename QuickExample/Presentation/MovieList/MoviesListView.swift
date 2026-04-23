//
//  ContentView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 15/01/26.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel
    private let imageLoader: ImageLoading
    
    init(
        viewModel: MoviesListViewModel,
        imageLoader: ImageLoading
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Data is loading ...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                List(viewModel.movies, id: \.id) { movie in
                    MovieListRowView(movie: movie, imageLoader: imageLoader)
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .refreshable {
            await viewModel.fetchMovies()
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}
