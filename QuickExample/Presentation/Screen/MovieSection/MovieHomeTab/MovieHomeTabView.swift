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
    let onCategoryTap: (String) -> Void
    let onMovieTap: (Int) -> Void
    
    init(viewModel: MovieHomeTabViewModel,
         imageLoader: ImageLoading,
         onCategoryTap: @escaping (String) -> Void,
         onMovieTap: @escaping (Int) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
        self.onCategoryTap = onCategoryTap
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
            onCategoryTap: onCategoryTap,
            onMediaItemTap: onMovieTap
        )
    }
}
