//
//  MovieRowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import SwiftUI

struct MovieListRowView: View {
    let movie: Movie
    let imageLoader: ImageLoading
    
    var body: some View {
        HStack {
            MoviePosterView(
                posterPath: movie.posterPath,
                imageLoader: imageLoader
            )
            MovieTextInfoView(movie: movie)
            Spacer()
        }
    }
}
