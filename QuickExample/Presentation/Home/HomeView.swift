//
//  HomeView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 21/04/26.
//

import SwiftUI

// TODO: handle states with loading, loaded, and failed with a default Image
struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    private let imageLoader: ImageLoading
    let onMovieTap: (Int) -> Void
    
    init(viewModel: HomeViewModel, imageLoader: ImageLoading, onMovieTap: @escaping (Int) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
        self.onMovieTap = onMovieTap
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                makeMovieCarouselSectionView(with: .popular)
                makeMovieCarouselSectionView(with: .upcoming)
                makeMovieCarouselSectionView(with: .topRated)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .task {
            await viewModel.fetchData()
        }
    }
    
    private func makeMovieCarouselSectionView(with category: MovieCategory) -> some View {
        MovieCarouselSectionView(
            imageLoader: imageLoader,
            category: category,
            data: viewModel.data(category: category),
            onMovieTap: onMovieTap
        )
    }
}
