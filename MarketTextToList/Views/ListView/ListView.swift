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
    @State var phone: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show favorites")
                }
                
                //                ForEach(0..<10, id: \.documentID) { shopping in
                //                    NavigationLink {
                //                        DetailsView(
                //                            title: shopping.title,
                //                            arrItems: shopping.items,
                //                            isFavorite: shopping.isFavorite,
                //                            documentID: shopping.documentID
                //                        )
                //                    } label: {
                //                        CardListView(
                //                            title: shopping.title,
                //                            data: shopping.data,
                //                            isFavorite: shopping.isFavorite
                //                        )
                //                    }
                //                }
            }
            .listStyle(.inset)
            .searchable(text: $search)
            .navigationTitle("Shopping lists")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .onAppear {
                guard let sharedPhoneNumber = Prefs.shared.sharedPhoneNumber else {return}
                self.phone = sharedPhoneNumber
            }
        }
    }
}

#Preview {
    ListView()
        .environmentObject(FirestoreOnboarding())
}
