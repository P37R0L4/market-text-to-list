//
//  Decodable.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 15/11/23.
//

import Foundation

extension Decodable {
    /// Initialize from JSON Dictionary. Return nil on failure
    init?(dictionary value: [String:Any]){
        
        guard JSONSerialization.isValidJSONObject(value) else { return nil }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else { return nil }
        
        guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        self = newValue
    }
}
