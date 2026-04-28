//
//  MovieCarouselSectionView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct MovieCarouselSectionView: View {
    let imageLoader: ImageLoading
    let category: MovieCategory
    let data: [Movie]
    let onMovieTap: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(value: AppRoute.movieList(category: category)) {
                HStack {
                    Text(category.title)
                        .font(.title.weight(.semibold))
                    Image(systemName: "chevron.right")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 8) {
                    ForEach(data, id: \.id) { movie in
                        Button {
                            onMovieTap(movie.id)
                        } label: {
                            MovieCarouselRowView(
                                movie: movie,
                                imageLoader: DefaultImageLoader(dataLoader: TMDBImageDataLoader())
                            )
                            .frame(width: 150)
                        }
                    }
                }
            }
        }
        .background(Color.clear)
    }
}
