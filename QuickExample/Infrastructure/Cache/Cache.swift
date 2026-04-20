//
//  Cache.swift
//  QuickExample
//
//  Created by Ivan Lopez on 20/04/26.
//

import Foundation

protocol Cache<Key, Value> {
    associatedtype Key: Hashable
    associatedtype Value
    
    func get(key: Key) async -> Value?
    func set(_ value: Value, for key: Key) async
    func remove(key: Key) async
    func removeAll() async
}
