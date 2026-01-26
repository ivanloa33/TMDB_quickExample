//
//  ContentView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 15/01/26.
//

import SwiftUI

enum Constants {
    enum Secrets {
        static let tmdbApiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWYwNjEzOTU2ZjRlYjQxMjBmYTY2NjcwZDg2MTdhMiIsIm5iZiI6MTY2NjYzNTU1OC43MzYsInN1YiI6IjYzNTZkNzI2NTZiOWY3MDA3ZTJmZGE5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4ukJ2nIYGcwdc4OvdfjZKaGaxNlIGzooFzZMQcvX4o8"
    }
    enum Image {
        static let baseUrl = "https://image.tmdb.org/t/p/w500"
    }
}

struct PopularMoviesListView: View {
    @StateObject var popularMoviesListViewModel = PopularMoviesListViewModel(fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseImpl(repository: MoviesRepositoryImpl()))
    
    let imageLoader: ImageLoading = TMDBImageLoader()
    
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
