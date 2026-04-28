//
//  MovieDetailView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 24/04/26.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    let imageLoader: ImageLoading
    
    init(viewModel: MovieDetailViewModel,
         imageLoader: ImageLoading
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        LoadableView(state: viewModel.state) {
            await viewModel.load()
        } content: { movieDetail in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    heroSection
                    overviewSection
                        .padding(.horizontal)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .task {
            await viewModel.loadIfNeeded()
        }
    }
    
    private var heroSection: some View {
        ZStack(alignment: .topLeading) {
            MoviePosterView(
                posterPath: viewModel.movieDetail?.backdropPath ?? String(),
                imageLoader: imageLoader
            )
            .opacity(0.8)
            .scaledToFill()
            
            heroContent
                .padding()
        }
    }
    
    private var heroContent: some View {
        HStack(alignment: .bottom, spacing: 16) {
            if let posterPath = viewModel.movieDetail?.posterPath {
                MoviePosterView(
                    posterPath: posterPath,
                    imageLoader: imageLoader
                )
                .frame(width: 120, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(radius: 8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.movieDetail?.title ?? "")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                
                Text(viewModel.metadataText)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
                
                Text(viewModel.genreText)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
                    .lineLimit(1)
            }
        }
    }
    
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Overview")
                .font(.title2.weight(.semibold))
            
            Text(viewModel.movieDetail?.overview ?? "")
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
    }
}
