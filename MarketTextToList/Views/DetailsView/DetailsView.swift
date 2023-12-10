//
//  DEtailsView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 21/10/23.
//

import SwiftUI
import VisionKit

struct DetailsView: View {
    @State private var scanResults: String = "Scanned text here"
    @State private var showDeviceNotCapacityAlert = false
    @State private var showCameraScannerView = false
    @State private var isDeviceCapacity = false
    
    @State private var arrItems = [Items]()
    @State private var search: String = ""
    
    var title: String
    var id: String
    var isFavorite: Bool
    
    var filteredItem: [Items] {
        search != "" ? arrItems.filter {$0.item.lowercased().contains(search.lowercased())} : arrItems
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(filteredItem, id: \.item) { item in
                    DetailListView(title: item.item, price: item.price)
                        .strikethrough(item.selected)
                        .swipeActions {
                            Button("delete", role: .destructive) {
                                
                            }
                            
                            Button("Mark") {
                                
                            }
                        }
                }
            }
            .listStyle(.inset)
            Text(scanResults)
        }
        .navigationTitle(title)
        .searchable(text: $search)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    guard isDeviceCapacity else {
                        self.showDeviceNotCapacityAlert = false
                        return
                    }
                    
                    self.showCameraScannerView = true
                } label: {
                    Label("open camera", systemImage: "camera")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    FirestoreShoppingList().update(uid: id, data: ["isFavorite": !isFavorite])
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .accentColor)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onAppear {
            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
            
            handleList()
        }
        .sheet(isPresented: $showCameraScannerView) {
            CameraScannerView(
                startScanning: $showCameraScannerView,
                showCameraScannerView: $showCameraScannerView,
                scanResult: $scanResults
            )
        }
        .alert(
            "Scanner Unavailable",
            isPresented: $showDeviceNotCapacityAlert,
            actions: {}
        )
    }
    
    func handleList () {
        FirestoreShoppingList().fetchShoppingList(document: id) { shoppingListData in
            arrItems = shoppingListData.items
        }
    }
}

#Preview {
    DetailsView(
        title: "Fichas de jogo do bicho",
        id: "",
        isFavorite: false
    )
}
