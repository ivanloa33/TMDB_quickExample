//
//  PopularMoviesListViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation
import Combine

@MainActor
final class MoviesListViewModel: ObservableObject {
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let category: MovieCategory
    private(set) var navigationTitle: String
    
    init(category: MovieCategory, fetchMoviesUseCase: FetchMoviesUseCase,) {
        self.category = category
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.navigationTitle = "\(category.title) Movies"
    }
    
    func fetchMovies() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            movies = try await fetchMoviesUseCase.execute(category: category)
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
        }
    }
}
