//
//  MovieHomeTabView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 21/04/26.
//

import SwiftUI

struct MovieHomeTabView: View {
    @StateObject private var viewModel: MovieHomeTabViewModel
    private let imageLoader: ImageLoading
    let onMovieTap: (Int) -> Void
    
    init(viewModel: MovieHomeTabViewModel, imageLoader: ImageLoading, onMovieTap: @escaping (Int) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
        self.onMovieTap = onMovieTap
    }
    
    var body: some View {
        LoadableView(state: viewModel.state, onRetry: {
            await viewModel.load()
        }) { _ in
            contentView
        }
        .task {
            await viewModel.loadIfNeeded()
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 20) {
                makeMovieCarouselSectionView(with: .popular)
                makeMovieCarouselSectionView(with: .upcoming)
                makeMovieCarouselSectionView(with: .topRated)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
    
    private func makeMovieCarouselSectionView(with category: MovieCategory) -> some View {
        CarouselSectionView(
            imageLoader: imageLoader,
            category: (rawValue: category.rawValue, title: category.title),
            data: viewModel.data(category: category),
            onMediaItemTap: onMovieTap
        )
    }
}
