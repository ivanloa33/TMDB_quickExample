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
    @Published private(set) var state: LoadableState<[Movie]> = .idle
    
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let category: MovieCategory
    private(set) var navigationTitle: String
    
    init(category: MovieCategory, fetchMoviesUseCase: FetchMoviesUseCase,) {
        self.category = category
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.navigationTitle = "\(category.title) Movies"
    }
    
    func loadIfNeeded() async {
        guard case .idle = state else {
            return
        }
        await load()
    }
    
    func load() async {
        await fetchMovies()
    }
    
    private func fetchMovies() async {
        state = .loading
        do {
            let movies = try await fetchMoviesUseCase.execute(category: category)
            state = .loaded(movies)
        } catch {
            state = .failed(error)
        }
    }
}
