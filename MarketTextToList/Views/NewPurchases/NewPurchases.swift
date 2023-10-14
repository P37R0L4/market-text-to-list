//
//  CameraView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI
import VisionKit

struct NewPurchases: View {
    @State private var scanResults: String = "Scanned text here"
    @State private var showDeviceNotCapacityAlert = false
    @State private var showCameraScannerView = false
    @State private var isDeviceCapacity = false
    
    var body: some View {
        VStack {
            NewPurchasesForm()
            //            Text(scanResults)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
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
            
            ToolbarItem(placement: .confirmationAction) {
                Button {} label: {
                    Text("Done")
                }
            }
        }
        .onAppear {
            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
        }
        .sheet(isPresented: $showCameraScannerView, content: {
            CameraScannerView(
                startScanning: $showCameraScannerView,
                showCameraScannerView: $showCameraScannerView,
                scanResult: $scanResults
            )
        })
        .alert("Scanner Unavailable", isPresented: $showDeviceNotCapacityAlert, actions: {})
    }
}

#Preview {
    NewPurchases()
}
