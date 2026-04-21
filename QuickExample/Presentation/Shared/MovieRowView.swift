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
    
    private var releaseDateText: String {
        DisplayDateFormatter.medium.string(from: movie.releaseDate)
    }
    
    var body: some View {
        HStack {
            MoviePosterView(
                posterPath: movie.posterPath,
                imageLoader: imageLoader
            )
            VStack(alignment: .leading, spacing: 13) {
                Text(movie.title)
                    .font(.headline)
                Text(releaseDateText)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            Spacer()
        }
    }
}
