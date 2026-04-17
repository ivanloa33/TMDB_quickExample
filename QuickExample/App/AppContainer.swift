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
        self.repository = MoviesRepositoryImpl()
        self.imageDataLoader = TMDBImageDataLoader()
        self.imageLoader = DefaultImageLoader(dataLoader: imageDataLoader)
    }
    
    func makePopularMoviesListView() -> some View {
        let useCase = FetchPopularMoviesUseCaseImpl(repository: repository)
        let viewModel = PopularMoviesListViewModel(fetchPopularMoviesUseCase: useCase)
        
        return PopularMoviesListView(
            viewModel: viewModel,
            imageLoader: imageLoader
        )
    }
}
