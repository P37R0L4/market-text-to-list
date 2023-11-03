//
//  ListView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var firestoreManager = FirestoreManager()
    @State private var searchQuery: String = ""
    @State var showFavoritesOnly: Bool = false
    
    var filteredShoppingList: [ShoppingCard] {
        firestoreManager.shopping.filter { ShoppingCard in
            (!showFavoritesOnly || ShoppingCard.isFavorite)
        }
    }
    
    var searchedShoppingList: [ShoppingCard] {
        filteredShoppingList
            .filter { searched in
                searchQuery.isEmpty ? true : searched.title.contains(searchQuery)
            }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show favorites")
                }
                
                ForEach(searchedShoppingList, id: \.documentID) { shopping in
                    NavigationLink {
                        DetailsView(
                            title: shopping.title,
                            arrItems: shopping.items,
                            isFavorite: shopping.isFavorite,
                            documentID: shopping.documentID
                        )
                    } label: {
                        CardListView(
                            title: shopping.title,
                            data: shopping.data,
                            firstPurchase: shopping.firstPurchase,
                            shareWith: shopping.shareWith,
                            isFavorite: shopping.isFavorite
                        )
                    }
                }
            }
            .listStyle(.inset)
            .searchable(text: $searchQuery)
            .navigationTitle("Shopping lists")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Label("camera", systemImage: "camera")
                    }
                }
            }
        } detail: {
            Text("Select your list")
        }
        .onAppear {
            self.firestoreManager.fetchAllShopping()
        }
    }
}

#Preview {
    ListView()
        .environmentObject(FirestoreManager())
}
