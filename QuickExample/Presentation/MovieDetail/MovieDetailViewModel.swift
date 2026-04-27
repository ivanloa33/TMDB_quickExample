//
//  MovieDetailViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 25/04/26.
//

import Combine

final class MovieDetailViewModel: ObservableObject {
    
    @Published private(set) var state: LoadableState<MovieDetail> = .idle
    
    let movieId: Int
    let fetchMovieDetailUseCase: FetchMovieDetailUseCase
    
    init(movieId: Int, fetchMovieDetailUseCase: FetchMovieDetailUseCase) {
        self.movieId = movieId
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
    }
    
    func loadIfNeeded() async {
        guard case .idle = state else {
            return
        }
        await load()
    }
    
    func load() async {
        await fetchMovieDetail()
    }
    
    private func fetchMovieDetail() async {
        do {
            state = .loading
            let movieDetail = try await fetchMovieDetailUseCase.execute(movieId: movieId)
            state = .loaded(movieDetail)
        } catch {
            state = .failed(error)
        }
    }
}

