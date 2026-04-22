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
        VStack(alignment: .leading, spacing: 13) {
            Text(movie.title)
                .font(.headline)
            Text(movie.releaseDateText)
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
    }
}
