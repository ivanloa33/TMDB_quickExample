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
            HStack {
                Text(category.title)
                    .font(.title3.weight(.semibold))
                Spacer()
                NavigationLink(value: AppRoute.movieList(category: category)) {
                    Text("View All")
                }
            }
            
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
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 6, y: 2)
    }
}
