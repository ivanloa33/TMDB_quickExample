//
//  HTTPClient.swift
//  QuickExample
//
//  Created by Ivan Lopez on 22/01/26.
//

import Foundation

protocol HTTPClient {
    func get<T: Decodable>(endPoint: EndPoint) async throws -> T
}
