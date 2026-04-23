//
//  RootView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/04/26.
//

import SwiftUI

struct RootView: View {
    let container: AppContainer
    
    var body: some View {
        NavigationStack {
            container.makeHomeView()
                .navigationDestination(for: MovieCategory.self) { category in
                    container.makeMovieListView(category)
                }
                .navigationTitle("Movies")
        }
    }
}
