//
//  UpcomingMoviesPolicy.swift
//  QuickExample
//
//  Created by Ivan Lopez on 28/04/26.
//

import Foundation

struct MovieReleaseDatePolicy {
    private let dateWindowPolicy: DateWindowPolicy

    init(dateWindowPolicy: DateWindowPolicy) {
        self.dateWindowPolicy = dateWindowPolicy
    }

    private func allows(_ movie: Movie, relativeTo referenceDate: Date = Date()) -> Bool {
        dateWindowPolicy.contains(movie.releaseDate, relativeTo: referenceDate)
    }

    func filter(_ movies: [Movie], relativeTo referenceDate: Date = Date()) -> [Movie] {
        movies.filter { allows($0, relativeTo: referenceDate) }
    }
}
