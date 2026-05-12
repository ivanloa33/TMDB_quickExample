//
//  TVShowListView.swift
//  QuickExample
//
//  Created by Ivan Lopez Ansaldo on 12/05/26.
//

import SwiftUI

struct TVShowListView: View {
    @StateObject private var viewModel: TVShowListViewModel
    private let imageLoader: ImageLoading
    private let onTVShowTap: (Int) -> Void
    
    init(
        viewModel: TVShowListViewModel,
        imageLoader: ImageLoading,
        onTVShowTap: @escaping (Int) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
        self.onTVShowTap = onTVShowTap
    }
    
    var body: some View {
        LoadableView(state: viewModel.state, onRetry: {
            await viewModel.load()
        }) { content in
            ScrollView {
                LazyVStack {
                    ForEach(content, id: \.id) { tvShow in
                        Button {
                            onTVShowTap(tvShow.id)
                        } label: {
                            MediaItemListRowView(mediaItem: tvShow, imageLoader: imageLoader)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .refreshable {
            await viewModel.load()
        }
        .task {
            await viewModel.loadIfNeeded()
        }
    }
}
