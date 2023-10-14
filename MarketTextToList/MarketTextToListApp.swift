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
    let persistenceController = PersistenceController.shared
    
    // register app delegate for Firebase setup
    @StateObject var firestoreManager = FirestoreManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(firestoreManager)
        }
    }
}
