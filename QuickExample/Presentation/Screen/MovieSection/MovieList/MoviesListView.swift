//
//  ContentView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 15/01/26.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel: MoviesListViewModel
    private let imageLoader: ImageLoading
    private let onMovieTap: (Int) -> Void
    
    init(
        viewModel: MoviesListViewModel,
        imageLoader: ImageLoading,
        onMovieTap: @escaping (Int) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
        self.onMovieTap = onMovieTap
    }
    
    var body: some View {
        LoadableView(state: viewModel.state, onRetry: {
            await viewModel.load()
        }) { content in
            ScrollView {
                LazyVStack {
                    ForEach(content, id: \.id) { movie in
                        Button {
                            onMovieTap(movie.id)
                        } label: {
                            ListRowView(mediaItem: movie, imageLoader: imageLoader)
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
