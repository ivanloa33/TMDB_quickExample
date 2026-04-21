//
//  PopularMoviesListViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation
import Combine

@MainActor
final class PopularMoviesListViewModel: ObservableObject {
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    private let fetchMoviesUseCase: FetchMoviesUseCase
    
    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }
    
    func fetchPopularMovies() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            movies = try await fetchMoviesUseCase.execute(category: .popular)
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
        }
    }
}
