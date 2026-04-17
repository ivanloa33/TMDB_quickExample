//
//  MovieRowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    let imageLoader: ImageLoading
    
    var body: some View {
        HStack {
            MoviePosterView(
                posterPath: movie.posterPath,
                imageLoader: imageLoader
            )
            Text(movie.title)
                .font(.headline)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}
