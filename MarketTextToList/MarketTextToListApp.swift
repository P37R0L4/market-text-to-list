//
//  MarketTextToListApp.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI
import Firebase

@main
struct MarketTextToListApp: App {
    @StateObject var firestoreManager = FirestoreManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
        }
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
