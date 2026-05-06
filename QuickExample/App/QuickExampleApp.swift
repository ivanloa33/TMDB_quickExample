//
//  QuickExampleApp.swift
//  QuickExample
//
//  Created by Ivan Lopez on 15/01/26.
//

import SwiftUI

@main
struct QuickExampleApp: App {
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(\.container, container)
        }
    }
}
