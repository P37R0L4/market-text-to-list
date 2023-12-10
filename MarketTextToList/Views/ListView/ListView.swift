//
//  ListView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI

struct ListView: View {
    @State private var search: String = ""
    @State var showFavoritesOnly: Bool = false
    @State var lists = [Lists]()
    
    var filteredList: [Lists] {
        search == ""
        ? lists.filter { lists in
            (!showFavoritesOnly || lists.isFavorite)
        }
        : lists.filter {$0.title.lowercased().contains(search.lowercased())}
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show favorites")
                }
                
                ForEach(filteredList) { itemList in
                    NavigationLink {
                        DetailsView(
                            title: itemList.title,
                            id: itemList.id,
                            isFavorite: itemList.isFavorite
                        )
                    } label: {
                        CardListView(
                            title: itemList.title,
                            data: itemList.data,
                            isFavorite: itemList.isFavorite
                        )
                    }
                }
            }
            .listStyle(.inset)
            .searchable(text: $search)
            .navigationTitle("List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .onAppear {
                handleShoppingLists()
            }
        }
    }
    
    func handleShoppingLists () {
        if let sharedPhoneNumber = Prefs.shared.sharedPhoneNumber {
            FirestoreOnboarding().fetchSignIn(number: sharedPhoneNumber) { onboardingData in
                self.lists = onboardingData.lists
            }
        }
    }
}

#Preview {
    ListView()
}
