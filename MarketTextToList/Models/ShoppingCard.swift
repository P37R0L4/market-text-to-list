//
//  ShoppingCardModel.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 14/10/23.
//

import Foundation
import MapKit
import Firebase

struct Items: Hashable, Codable {
    let item: String
    let selected: Bool
}

struct ShoppingCard: Hashable, Codable {
    var documentID: String = ""
    let title: String
    let data: Date
    let firstPurchase: Bool
    let items: [Items]
    let shareWith: String
    let amount: Int
    let isFavorite: Bool
    
    var localization: GeoPoint
}
