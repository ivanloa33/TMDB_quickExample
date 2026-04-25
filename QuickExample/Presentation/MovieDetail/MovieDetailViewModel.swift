//
//  MovieDetailViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 25/04/26.
//

import Combine

final class MovieDetailViewModel: ObservableObject {
    
    @Published private(set) var movieDetail: MovieDetail?
    
    let movieId: Int
    let fetchMovieDetailUseCase: FetchMovieDetailUseCase
    
    init(movieId: Int, fetchMovieDetailUseCase: FetchMovieDetailUseCase) {
        self.movieId = movieId
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
    }
    
    func fetchMovieDetail() async {
        let movieDetail = try? await fetchMovieDetailUseCase.execute(movieId: movieId)
        self.movieDetail = movieDetail
    }
}

