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
            ListView()
                .tabItem {
                    Label("Shopping List", systemImage: "list.bullet.clipboard")
                }
            
            NewPurchases()
                .tabItem {
                    Label("New", systemImage: "square.and.pencil")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
