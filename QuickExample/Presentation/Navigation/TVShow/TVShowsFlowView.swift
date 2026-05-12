//
//  TVShowsFlowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 06/05/26.
//

import SwiftUI

struct TVShowsFlowView: View {
    @Environment(\.container) private var container: AppContainer
    @State private var path: [TVShowRoute] = []
    @State private var selectedTVShowDetail: MediaItemDetailRoute?
    
    var body: some View {
        NavigationStack(path: $path) {
            container.tvShows.makeTVShowHomeView(
                onCategoryTap: handleOnCategoryTap,
                onTVShowTap: handleOnTVShowTap
            )
            .sheet(item: $selectedTVShowDetail, content: { id in
                Text("TVShowDetail")
            })
            .navigationDestination(for: TVShowRoute.self) { route in
                switch route {
                case .tvShowlist(let category):
                    container.tvShows.makeTVShowListView(
                        category,
                        onTVShowTap: handleOnTVShowTap
                    )
                }
            }
            .navigationTitle("TV Shows")
        }
    }
    
    private func handleOnCategoryTap(categoryRawValue: String) {
        if let category = TVShowCategory(rawValue: categoryRawValue) {
            path.append(.tvShowlist(category: category))
        }
    }
    
    private func handleOnTVShowTap(tvShowId: Int) {
        selectedTVShowDetail = MediaItemDetailRoute(id: tvShowId)
    }
}
