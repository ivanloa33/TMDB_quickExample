//
//  InMemoryCache.swift
//  QuickExample
//
//  Created by Ivan Lopez on 20/04/26.
//

import Foundation

actor InMemoryCache<Key: Hashable, Value>: Cache {
    
    private var storage = [Key: Value]()
    
    func get(key: Key) async -> Value? {
        storage[key]
    }
    
    func set(_ value: Value, for key: Key) async {
        storage[key] = value
    }
    
    func remove(key: Key) async {
        storage.removeValue(forKey: key)
    }
    
    func removeAll() async {
        storage.removeAll()
    }
}
