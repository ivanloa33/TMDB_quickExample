//
//  TVShowHomeTabViewModel.swift
//  QuickExample
//
//  Created by Ivan Lopez on 06/05/26.
//

import Combine

final class TVShowHomeTabViewModel: ObservableObject {
    @Published private(set) var state: LoadableState<[TVShowCategory: [TVShow]]> = .idle
    
    private let fetchTVShowUseCase: FetchTVShowsUseCase
    
    init(fetchTVShowUseCase: FetchTVShowsUseCase) {
        self.fetchTVShowUseCase = fetchTVShowUseCase
    }
    
    func load() async {
        await fetchData()
    }
    
    func loadIfNeeded() async {
        guard case .idle = state else {
            return
        }
        await load()
    }
    
    func data(category: TVShowCategory) -> [TVShow] {
        guard case .loaded(let tvShowsByCategory) = state else {
            return []
        }
        return Array((tvShowsByCategory[category] ?? []).prefix(5))
    }
    
    private func fetchData() async {
        do {
            var tvShowsByCategory = [TVShowCategory: [TVShow]]()
            state = .loading
            
            async let onTheAirTVShows = fetchTVShows(category: .onTheAir)
            async let popularTVShows = fetchTVShows(category: .popular)
            async let topRatedTVShows = fetchTVShows(category: .topRated)
            
            await tvShowsByCategory[.onTheAir] = try onTheAirTVShows
            await tvShowsByCategory[.popular] = try popularTVShows
            await tvShowsByCategory[.topRated] = try topRatedTVShows
            
            state = .loaded(tvShowsByCategory)
        } catch {
            state = .failed(error)
        }
    }
    
    private func fetchTVShows(category: TVShowCategory) async throws -> [TVShow] {
        do {
            return try await fetchTVShowUseCase.execute(category: category)
        } catch {
            throw error
        }
    }
}
