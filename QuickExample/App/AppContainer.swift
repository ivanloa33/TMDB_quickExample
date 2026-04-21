//
//  AppContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import SwiftUI

final class AppContainer {
    
    private let repository: MoviesRepository
    private let imageDataLoader: ImageDataLoading
    private let imageLoader: ImageLoading
    
    init() {
        let httpClient = URLSessionHTTPClient()
        let cache: any Cache<CacheKey, [CacheMovie]> = InMemoryCache()
        self.repository = MoviesRepositoryImpl(
            httpClient: httpClient,
            cache: cache
        )
        self.imageDataLoader = TMDBImageDataLoader()
        self.imageLoader = DefaultImageLoader(dataLoader: imageDataLoader)
    }
    
    func makePopularMoviesListView() -> some View {
        let useCase = FetchMoviesUseCaseImpl(repository: repository)
        let viewModel = PopularMoviesListViewModel(fetchMoviesUseCase: useCase)
        
        return PopularMoviesListView(
            viewModel: viewModel,
            imageLoader: imageLoader
        )
    }
}
