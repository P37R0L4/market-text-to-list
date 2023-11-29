//
//  Encodable.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 15/11/23.
//

import Foundation

extension Encodable {
    /// Returns a JSON dictionary, with choice of minimal information
    func getDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any]
        }
    }
}
