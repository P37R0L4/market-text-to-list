//
//  ListViewController.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import Foundation

class ListViewController {
    
    public let timestampFormat: DateFormatter = {
        let formatter = DateFormatter()        
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        return formatter
    }()
}
