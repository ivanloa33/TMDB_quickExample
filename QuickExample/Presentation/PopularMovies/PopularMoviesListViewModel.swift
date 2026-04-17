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
    
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    
    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
    }
    
    func fetchPopularMovies() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            movies = try await fetchPopularMoviesUseCase.execute()
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
        }
    }
}
