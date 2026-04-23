//
//  MovieTextInfoView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct MovieTextInfoView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .frame(height: 44, alignment: .topLeading)
            Text(movie.releaseDateText)
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .frame(width: 150)
    }
}
