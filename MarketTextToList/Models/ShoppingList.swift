//
//  ShoppingList.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 14/10/23.
//

import Foundation

struct Items: Codable {
    let item: String
    let selected: Bool
}

struct ShoppingList: Codable {
    let documentID: String
    let title: String
    let data: Date
    var items: [Items]
    let amount: Int
    let isFavorite: Bool
}
