//
//  TVShowsContainer.swift
//  QuickExample
//
//  Created by Ivan Lopez on 04/05/26.
//

import SwiftUI

final class TVShowsContainer {
    private let core: CoreContainer
    
    private let repository: TVShowsRepository
    private let fetchTVShowsUseCase: FetchTVShowsUseCase
    
    init(core: CoreContainer) {
        self.core = core
        
        let repository = TVShowsRepositoryImpl(httpClient: core.httpClient)
        
        self.repository = repository
        
        self.fetchTVShowsUseCase = FetchTVShowsUseCaseImpl(repository: repository)
    }
    
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
