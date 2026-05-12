//
//  TextInfoView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct TextInfoView: View {
    let mediaItem: MediaItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(mediaItem.titleText)
                .font(.headline)
                .foregroundStyle(Color.primary)
                .lineLimit(2)
                .frame(height: 48, alignment: .topLeading)
            Text(mediaItem.releaseDateText)
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .multilineTextAlignment(.leading)
        .frame(width: 150)
    }
}
