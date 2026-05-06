//
//  RootTabView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 06/05/26.
//

import SwiftUI

struct RootTabView: View {
    
    var body: some View {
        TabView {
            Tab {
                MoviesFlowView()
            } label: {
                Label("Movies", systemImage: "film")
            }
            
            Tab {
                TVShowsFlowView()
            } label: {
                Label("TV Shows", systemImage: "tv")
            }
            
        }
    }
}
