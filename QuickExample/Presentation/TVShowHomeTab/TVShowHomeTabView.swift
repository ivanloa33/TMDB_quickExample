//
//  TVShowHomeTabView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 05/05/26.
//

import SwiftUI

struct TVShowHomeTabView: View {
    @StateObject private var viewModel: TVShowHomeTabViewModel
    private let imageLoader: ImageLoading
    let onTVShowTap: (Int) -> Void
    
    init(viewModel: TVShowHomeTabViewModel, imageLoader: ImageLoading, onTVShowTap: @escaping (Int) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
        self.onTVShowTap = onTVShowTap
    }
    
    var body: some View {
        LoadableView(state: viewModel.state) {
            await viewModel.load()
        } content: { _ in
            contentView
        }
        .task {
            await viewModel.loadIfNeeded()
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 20) {
                makeTVShowCarouselSectionView(with: .onTheAir)
                makeTVShowCarouselSectionView(with: .popular)
                makeTVShowCarouselSectionView(with: .topRated)
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
    
    private func makeTVShowCarouselSectionView(with category: TVShowCategory) -> some View {
        CarouselSectionView(
            imageLoader: imageLoader,
            category: (rawValue: category.rawValue, title: category.title),
            data: viewModel.data(category: category),
            onMediaItemTap: onTVShowTap
        )
    }
}
