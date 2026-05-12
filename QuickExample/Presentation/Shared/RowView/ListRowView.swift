//
//  MovieRowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import SwiftUI

struct ListRowView: View {
    let mediaItem: MediaItem
    let imageLoader: ImageLoading
    
    var body: some View {
        HStack {
            MoviePosterView(
                posterPath: mediaItem.posterPath,
                imageLoader: imageLoader
            )
            .frame(width: 120, height: 180)
            .clipped()
            MediaItemTextInfoView(mediaItem: mediaItem)
            Spacer()
        }
    }
}
