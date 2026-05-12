//
//  MovieHomeTabViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import Combine

@MainActor
final class MovieHomeTabViewModel: ObservableObject {
    @Published private(set) var state = LoadableState<[MovieCategory: [Movie]]>.idle
    
    let fetchMoviesUseCase: FetchMoviesUseCase
    
    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }
    
    func loadIfNeeded() async {
        guard case .idle = state else {
            return
        }
        await load()
    }
    
    func load() async {
        await fetchData()
    }
    
    func data(category: MovieCategory) -> [Movie] {
        guard case .loaded(let moviesByCategory) = state else {
            return []
        }
        
        return Array((moviesByCategory[category] ?? []).prefix(5))
    }
    
    private func fetchData() async {
        do {
            var moviesByCategory = [MovieCategory: [Movie]]()
            state = .loading
            
            async let popularMovies = fetchMovies(category: .popular)
            async let upcomingMovies = fetchMovies(category: .upcoming)
            async let topRatedMovies = fetchMovies(category: .topRated)
            
            await moviesByCategory[.popular] = try popularMovies
            await moviesByCategory[.upcoming] = try upcomingMovies
            await moviesByCategory[.topRated] = try topRatedMovies
            
            state = .loaded(moviesByCategory)
        } catch {
            state = .failed(error)
        }
    }
    
    private func fetchMovies(category: MovieCategory) async throws -> [Movie] {
        do {
            return try await fetchMoviesUseCase.execute(category: category)
        } catch {
            throw error
        }
    }
}
