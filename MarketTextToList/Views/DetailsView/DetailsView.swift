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
    
    @ObservedObject var firestoreManager = FirestoreManager()
    
    var title: String
    var arrItems: [Items]
    var isFavorite: Bool
    var documentID: String
    
    var body: some View {
        VStack {
            List {
                ForEach(arrItems, id: \.item) { item in
                    Text(item.item)
                }
                .onDelete(perform: { indexSet in
                    
                })
            }
            Text(scanResults)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
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
                    firestoreManager.update(uid: documentID, data: ["isFavorite": !isFavorite])
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .accentColor)
                }
            }
        }
        .onAppear {
            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
        }
        .sheet(isPresented: $showCameraScannerView) {
            CameraScannerView(
                startScanning: $showCameraScannerView,
                showCameraScannerView: $showCameraScannerView,
                scanResult: $scanResults
            )
        }
        .alert("Scanner Unavailable", isPresented: $showDeviceNotCapacityAlert, actions: {})
    }
}

#Preview {
    DetailsView(
        title: "Compras em app",
        arrItems: [
            Items(item: "Porra de macaco", selected: false),
            Items(item: "Cu de travesti", selected: false),
        ],
        isFavorite: false,
        documentID: ""
    )
}