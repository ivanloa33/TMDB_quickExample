//
//  CarouselRowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct CarouselRowView: View {
    let mediaItem: MediaItem
    let imageLoader: ImageLoading
    
    var body: some View {
        VStack {
            MoviePosterView(
                posterPath: mediaItem.posterPath,
                imageLoader: imageLoader
            )
            .frame(width: 120, height: 180)
            .clipped()
            MediaItemTextInfoView(mediaItem: mediaItem)
        }
        .padding(.vertical)
    }
}
