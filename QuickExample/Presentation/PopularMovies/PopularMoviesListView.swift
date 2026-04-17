//
//  ContentView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 15/01/26.
//

import SwiftUI

struct PopularMoviesListView: View {
    @StateObject var viewModel: PopularMoviesListViewModel
    private let imageLoader: ImageLoading
    
    init(
        viewModel: PopularMoviesListViewModel,
        imageLoader: ImageLoading
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Data is loading ...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    List(viewModel.movies, id: \.id) { movie in
                        MovieRowView(movie: movie, imageLoader: imageLoader)
                    }
                }
            }
            .navigationTitle("Popular Movies")
            .task {
                await viewModel.fetchPopularMovies()
            }
        }
    }
}
