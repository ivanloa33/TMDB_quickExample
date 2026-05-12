//
//  MoviesContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 04/05/26.
//

import SwiftUI

final class MoviesContainer {
    private let core: CoreContainer
    
    private let cacheMovieSection: any Cache<MovieSectionCacheKey, [CacheMovie]>
    private let cacheMovieDetail: any Cache<Int, CacheMovieDetail>
    
    private let repository: MoviesRepository
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let fetchMovieDetailUseCase: FetchMovieDetailUseCase
    
    init(core: CoreContainer) {
        self.core = core
        
        let cacheMovieSection = InMemoryCache<MovieSectionCacheKey, [CacheMovie]>()
        let cacheMovieDetail = InMemoryCache<Int, CacheMovieDetail>()
        
        self.cacheMovieSection = cacheMovieSection
        self.cacheMovieDetail = cacheMovieDetail
        
        let repository = MoviesRepositoryImpl(
            httpClient: core.httpClient,
            cache: cacheMovieSection,
            cacheMovieDetail: cacheMovieDetail
        )
        self.repository = repository
        
        self.fetchMoviesUseCase = FetchMoviesUseCaseImpl(repository: repository)
        self.fetchMovieDetailUseCase = FetchMovieDetailUseCaseImpl(repository: repository)
    }
}

extension MoviesContainer {
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
            imageLoader: core.imageLoader,
            onMovieTap: onMovieTap
        )
    }
    
    func makeMovieDetailView(from movieId: Int) -> some View {
        let viewModel = MovieDetailViewModel(
            movieId: movieId,
            fetchMovieDetailUseCase: fetchMovieDetailUseCase)
        
        return MovieDetailView(viewModel: viewModel, imageLoader: core.imageLoader)
    }
    
    func makeMovieHomeView(
        onCategoryTap: @escaping (String) -> Void,
        onMovieTap: @escaping (Int) -> Void
    ) -> some View {
        let viewModel = MovieHomeTabViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
        
        return MovieHomeTabView(
            viewModel: viewModel,
            imageLoader: core.imageLoader,
            onCategoryTap: onCategoryTap,
            onMovieTap: onMovieTap)
    }
}
