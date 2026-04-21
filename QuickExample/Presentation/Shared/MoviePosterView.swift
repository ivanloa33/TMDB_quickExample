//
//  MoviePosterView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import SwiftUI

// TODO: handle states with loading, loaded, and failed with a default Image 
struct MoviePosterView: View {
    let posterPath: String
    let imageLoader: ImageLoading
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                ProgressView()
            }
        }
        .frame(width: 120, height: 180)
        .clipped()
        .task(id: posterPath) {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        image = try? await imageLoader.loadImage(from: posterPath)
    }
}
