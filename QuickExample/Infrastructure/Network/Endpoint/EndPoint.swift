//
//  EndPoint.swift
//  QuickExample
//
//  Created by Ivan Lopez on 27/01/26.
//

import Foundation

protocol EndPoint {
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var urlRequest: URLRequest { get }
}
