//
//  TVShowsFlowView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 06/05/26.
//

import SwiftUI

struct TVShowsFlowView: View {
    @Environment(\.container) private var container: AppContainer
    
    var body: some View {
        NavigationStack {
            container.tvShows.makeHomeView(onTVShowTap: handleOnTVShowTap)
                .navigationTitle("TV Shows")
        }
    }
    
    private func handleOnTVShowTap(movieId: Int) {
        
    }
}
