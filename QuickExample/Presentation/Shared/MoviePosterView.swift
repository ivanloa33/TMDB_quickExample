//
//  MoviePosterView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import SwiftUI

struct MoviePosterView: View {
    let posterPath: String
    let imageLoader: ImageLoading
    
    @State var image: UIImage?
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
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
        let url = URL(string: "\(Constants.Image.baseUrl)\(posterPath)")!
        image = try? await imageLoader.loadImage(from: url)
    }
}
