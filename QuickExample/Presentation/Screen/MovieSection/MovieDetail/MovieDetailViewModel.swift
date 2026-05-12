//
//  MovieDetailViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 25/04/26.
//

import Foundation
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
    
    var movieDetail: MovieDetail? {
        guard case .loaded(let value) = state else {
            return nil
        }
        return value
    }
    
    var metadataText: String {
        guard case .loaded(let movieDetail) = state else { return "" }
        
        let year = DisplayDateFormatter.year.string(from: movieDetail.releaseDate)
        let runtime = "\(movieDetail.runtime) min"
        let rating = String(format: "%.1f ★", movieDetail.voteAverage)
        
        return [year, runtime, rating]
            .joined(separator: " • ")
    }
    
    var genreText: String {
        guard case .loaded(let movieDetail) = state else { return "" }
        return movieDetail.genres.map(\.name).joined(separator: ", ")
    }
}

