//
//  Colors.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import Foundation
import SwiftUI

var backgroundColor: Color {
    if colorScheme == .dark {
        return Color(.systemGray5)
    } else {
        return Color(.systemGray6)
    }
}

var foregroundColor: Color {
    if colorScheme == .dark {
        return Color(.white)
    } else {
        return Color(.black)
    }
}
