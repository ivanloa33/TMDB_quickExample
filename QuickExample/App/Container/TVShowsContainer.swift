//
//  TVShowsContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 04/05/26.
//

import SwiftUI

final class TVShowsContainer {
    private let core: CoreContainer
    
    // MARK: - Not creating TVShowSectionCacheKey and CacheTVShow types
    // Keeping simpler and want to see when is necesarry dedicated CacheTypes
    private let cacheTVShowSection: any Cache<TVShowCategory, [TVShowDTO]>
    
    private let repository: TVShowsRepository
    private let fetchTVShowsUseCase: FetchTVShowsUseCase
    
    init(core: CoreContainer) {
        self.core = core
        
        let cacheTVShowSection = InMemoryCache<TVShowCategory, [TVShowDTO]>()
        self.cacheTVShowSection = cacheTVShowSection
        
        let repository = TVShowsRepositoryImpl(
            httpClient: core.httpClient,
            cache: cacheTVShowSection
        )
        
        self.repository = repository
        self.fetchTVShowsUseCase = FetchTVShowsUseCaseImpl(repository: repository)
    }
}

extension TVShowsContainer {
    func makeTVShowListView(
        _ category: TVShowCategory,
        onTVShowTap: @escaping (Int) -> Void
    ) -> some View {
        let viewModel = TVShowListViewModel(
            category: category,
            fetchTVShowsUseCase: fetchTVShowsUseCase
        )
        return TVShowListView(
            viewModel: viewModel,
            imageLoader: core.imageLoader,
            onTVShowTap: onTVShowTap
        )
    }
    
    func makeTVShowHomeView(
        onCategoryTap: @escaping (String) -> Void,
        onTVShowTap: @escaping (Int) -> Void
    ) -> some View {
        let viewModel = TVShowHomeTabViewModel(fetchTVShowUseCase: fetchTVShowsUseCase)
        return TVShowHomeTabView(
            viewModel: viewModel,
            imageLoader: core.imageLoader,
            onCategoryTap: onCategoryTap,
            onTVShowTap: onTVShowTap
        )
    }
}
