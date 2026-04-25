//
//  MovieDetailView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 24/04/26.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Movie Detail View")
            Text("Movie Id: \(viewModel.movieId)")
            
            if let movieDetail = viewModel.movieDetail {
                VStack {
                    Text(movieDetail.title)
                    Text(movieDetail.overview)
                    Text("\(movieDetail.runtime)")
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetchMovieDetail()
        }
    }
}

