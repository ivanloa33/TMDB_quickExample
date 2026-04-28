//
//  DateWindowPolicy.swift
//  QuickExample
//
//  Created by Ivan Lopez on 28/04/26.
//

import Foundation

struct DateWindowPolicy {
    private let calendar: Calendar
    private let pastMonths: Int
    private let futureMonths: Int?

    init(
        pastMonths: Int,
        futureMonths: Int? = nil,
        calendar: Calendar = .current
    ) {
        self.pastMonths = pastMonths
        self.futureMonths = futureMonths
        self.calendar = calendar
    }

    func contains(_ date: Date, relativeTo referenceDate: Date = Date()) -> Bool {
        let startOfReferenceDate = calendar.startOfDay(for: referenceDate)

        guard let startDate = calendar.date(
            byAdding: .month,
            value: -pastMonths,
            to: startOfReferenceDate
        ) else {
            return false
        }

        if let futureMonths {
            guard let endDate = calendar.date(
                byAdding: .month,
                value: futureMonths,
                to: startOfReferenceDate
            ) else {
                return false
            }

            return date >= startDate && date <= endDate
        }

        return date >= startDate
    }
}
