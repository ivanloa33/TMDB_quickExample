//
//  PopularMoviesListViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation
import Combine

final class PopularMoviesListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    
    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
    }
    
    @MainActor
    func fetchPopularMovies() async {
        defer {
            isLoading = false
        }
        self.isLoading = true
        self.errorMessage = nil
        do {
            self.movies = try await fetchPopularMoviesUseCase.execute()
        } catch {
            self.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
        }
    }
}
