//
//  DisplayDateFormatter.swift
//  QuickExample
//
//  Created by Ivan Lopez on 20/04/26.
//

import Foundation

enum DisplayDateFormatter {
    static let medium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
}
