//
//  Prefs.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 28/11/23.
//

import Foundation

class Prefs
{
    private let defaults = UserDefaults.standard
    
    private let userPhone = "userPhone"
    
    var sharedPhoneNumber: String? {
        set {
            defaults.setValue(newValue, forKey: userPhone)
        }
        get {
            return defaults.string(forKey: userPhone)
        }
    }
    
    class var shared: Prefs {
        struct Static {
            static let instance = Prefs()
        }
        
        return Static.instance
    }
}
