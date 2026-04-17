//
//  ContentView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 15/01/26.
//

import SwiftUI

struct PopularMoviesListView: View {
    @StateObject var popularMoviesListViewModel = PopularMoviesListViewModel(fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseImpl(repository: MoviesRepositoryImpl()))
    
    private let imageLoader: ImageLoading = DefaultImageLoader()
    
    var body: some View {
        NavigationView {
            Group {
                if popularMoviesListViewModel.isLoading {
                    ProgressView("Data is loading ...")
                } else if let errorMessage = popularMoviesListViewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    List(popularMoviesListViewModel.movies, id: \.id) { movie in
                        MovieRowView(movie: movie, imageLoader: imageLoader)
                    }
                }
            }
            .task {
                await popularMoviesListViewModel.fetchPopularMovies()
            }
            .navigationTitle("Popular Movies")
        }
    }
}

#Preview {
    PopularMoviesListView()
}
