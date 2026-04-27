//
//  LoadableView.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/04/26.
//

import SwiftUI

enum LoadableState<Value> {
    case idle
    case loading
    case loaded(Value)
    case failed(Error)
}

struct LoadableView<Value, Content: View>: View {
    let state: LoadableState<Value>
    let onRetry: (() async -> Void)?
    let content: (Value) -> Content
    
    var body: some View {
        Group {
            switch state {
            case .idle, .loading:
                ProgressView("Loading ...")
                
            case .loaded(let value):
                content(value)
                
            case .failed(let error):
                VStack(spacing: 12) {
                    Text("Something went wrong.")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .font(.body)
                    if let onRetry {
                        Button("Retry") {
                            Task {
                                await onRetry()
                            }
                        }
                    }
                }
            }
        }
    }
}
