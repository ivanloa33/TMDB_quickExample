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
        Text("Movie Detail View")
        Text("Movie Id: \(viewModel.movieId)")
    }
}

import Combine

final class MovieDetailViewModel: ObservableObject {
    let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
}
