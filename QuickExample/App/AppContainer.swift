//
//  AppContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import SwiftUI

final class AppContainer {
    private lazy var httpClient: HTTPClient = URLSessionHTTPClient()
    private lazy var cache: any Cache<CacheKey, [CacheMovie]> = InMemoryCache()
    private lazy var repository: MoviesRepository = MoviesRepositoryImpl(
        httpClient: httpClient,
        cache: cache
    )
    private lazy var imageDataLoader: ImageDataLoading = TMDBImageDataLoader()
    private lazy var imageLoader: ImageLoading = DefaultImageLoader(dataLoader: imageDataLoader)
    private lazy var fetchMoviesUseCase: FetchMoviesUseCase = FetchMoviesUseCaseImpl(
        repository: repository
    )
    private lazy var fetchMovieDetailUseCase: FetchMovieDetailUseCase = FetchMovieDetailUseCaseImpl(
        repository: repository
    )
    
    func makeMovieListView(
        _ category: MovieCategory,
        onMovieTap: @escaping (Int) -> Void
    ) -> some View {
        let viewModel = MoviesListViewModel(
            category: category,
            fetchMoviesUseCase: fetchMoviesUseCase
        )
        
        return MoviesListView(
            viewModel: viewModel,
            imageLoader: imageLoader,
            onMovieTap: onMovieTap
        )
    }
    
    func makeMovieDetailView(from movieId: Int) -> some View {
        let viewModel = MovieDetailViewModel(
            movieId: movieId,
            fetchMovieDetailUseCase: fetchMovieDetailUseCase)
        
        return MovieDetailView(viewModel: viewModel, imageLoader: imageLoader)
    }
    
    func makeHomeView(onMovieTap: @escaping (Int) -> Void) -> some View {
        let viewModel = HomeViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
        
        return HomeView(
            viewModel: viewModel,
            imageLoader: imageLoader,
            onMovieTap: onMovieTap)
    }
}
