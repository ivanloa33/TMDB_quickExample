//
//  CarouselSectionView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct CarouselSectionView: View {
    let imageLoader: ImageLoading
    let category: (rawValue: String, title: String)
    let data: [MediaItem]
    let onCategoryTap: (String) -> Void
    let onMediaItemTap: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                onCategoryTap(category.rawValue)
            } label: {
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
                    ForEach(data, id: \.id) { item in
                        Button {
                            onMediaItemTap(item.id)
                        } label: {
                            CarouselRowView(
                                mediaItem: item,
                                imageLoader: imageLoader
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
