//
//  APIDateFormatter.swift
//  QuickExample
//
//  Created by Ivan Lopez on 21/04/26.
//

import Foundation

enum APIDateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let expectedFormat = "yyyy-MM-dd"
        let formatter = DateFormatter()
        formatter.dateFormat = expectedFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
