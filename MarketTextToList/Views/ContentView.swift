//
//  ContentView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            TabScreensView(filter: .list)
                .tabItem {
                    Label("List", systemImage: "list.bullet.clipboard")
                }
            
            TabScreensView(filter: .markets)
                .tabItem {
                    Label("Markets", systemImage: "house")
                }
            
            TabScreensView(filter: .newCard)
                .tabItem {
                    Label("New", systemImage: "square.and.pencil")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
