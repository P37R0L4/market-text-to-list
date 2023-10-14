//
//  ListView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        VStack{
            Text("My restaurant: \(firestoreManager.shopping)")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    Image(systemName: "")
                } label: {
                    Label(
                        "new",
                        systemImage: "questionmark.bubble.fill"
                    )
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
    }
}

#Preview {
    ListView()
        .environmentObject(FirestoreManager())
}
