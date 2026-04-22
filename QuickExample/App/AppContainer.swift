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
    
    func makePopularMoviesListView() -> some View {
        let viewModel = PopularMoviesListViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
        
        return PopularMoviesListView(
            viewModel: viewModel,
            imageLoader: imageLoader
        )
    }
    
    func makeHomeView() -> some View {
        let viewModel = HomeViewModel(fetchMoviesUseCase: fetchMoviesUseCase)
        
        return HomeView(viewModel: viewModel, imageLoader: imageLoader)
    }
}
