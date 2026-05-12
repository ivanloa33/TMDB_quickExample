//
//  TVShowListViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez Ansaldo on 12/05/26.
//

import Combine

final class TVShowListViewModel: ObservableObject {
    @Published private(set) var state = LoadableState<[TVShow]>.idle
    private let category: TVShowCategory
    private(set) var navigationTitle: String
    private var fetchTVShowsUseCase: FetchTVShowsUseCase
    
    init(category: TVShowCategory, fetchTVShowsUseCase: FetchTVShowsUseCase) {
        self.category = category
        self.navigationTitle = "\(category.title) TVS"
        self.fetchTVShowsUseCase = fetchTVShowsUseCase
    }
    
    func loadIfNeeded() async {
        guard case .idle = state else { return }
        await load()
    }
    
    func load() async {
        await fetchTVShows()
    }
    
    private func fetchTVShows() async {
        state = .loading
        do {
            let tvShows = try await fetchTVShowsUseCase.execute(category: category)
            state = .loaded(tvShows)
        } catch {
            state = .failed(error)
        }
    }
}
