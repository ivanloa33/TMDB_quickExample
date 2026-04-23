//
//  HomeViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var moviesByCategory = [MovieCategory: [Movie]]()
    
    let fetchMoviesUseCase: FetchMoviesUseCase
    
    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }
    
    func fetchData() async {
        async let popularMovies = fetchMovies(category: .popular)
        async let upcomingMovies = fetchMovies(category: .upcoming)
        async let topRatedMovies = fetchMovies(category: .topRated)
        
        await self.moviesByCategory[.popular] = popularMovies
        await self.moviesByCategory[.upcoming] = upcomingMovies
        await self.moviesByCategory[.topRated] = topRatedMovies
    }
    
    func data(category: MovieCategory) -> [Movie] {
        return Array((moviesByCategory[category] ?? []).prefix(5))
    }
    
    private func fetchMovies(category: MovieCategory) async -> [Movie] {
        guard let movies = try? await fetchMoviesUseCase.execute(category: category) else {
            return []
        }
        return movies
    }
}
