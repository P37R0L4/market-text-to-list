//
//  ListViewController.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import Foundation

class DateController {
    
    public func timestampFormat(_ format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        
        return dateformat.string(from: self)
    }
}
