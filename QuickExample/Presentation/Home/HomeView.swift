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
    
    init(viewModel: HomeViewModel, imageLoader: ImageLoading) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                MovieCarouselSectionView(imageLoader: imageLoader, category: .popular, data: viewModel.data(category: .popular))
                MovieCarouselSectionView(imageLoader: imageLoader, category: .upcoming, data: viewModel.data(category: .upcoming))
                MovieCarouselSectionView(imageLoader: imageLoader, category: .topRated, data: viewModel.data(category: .topRated))
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .task {
            await viewModel.fetchData()
        }
    }
}
