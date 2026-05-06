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
    
    func makeHomeView(onTVShowTap: @escaping (Int) -> Void) -> some View {
        let viewModel = TVShowHomeTabViewModel(fetchTVShowUseCase: fetchTVShowsUseCase)
        return TVShowHomeTabView(
            viewModel: viewModel,
            imageLoader: core.imageLoader,
            onTVShowTap: onTVShowTap
        )
    }
}
