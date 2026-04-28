//
//  MovieCarouselRowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct MovieCarouselRowView: View {
    let movie: Movie
    let imageLoader: ImageLoading
    
    var body: some View {
        VStack {
            MoviePosterView(
                posterPath: movie.posterPath,
                imageLoader: imageLoader
            )
            .frame(width: 120, height: 180)
            .clipped()
            MovieTextInfoView(movie: movie)
        }
        .padding(.vertical)
    }
}
