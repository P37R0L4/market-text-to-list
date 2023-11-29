//
//  CameraScannerView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI

struct CameraScannerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var startScanning: Bool
    @Binding var showCameraScannerView: Bool
    @Binding var scanResult: String
    
    var body: some View {
        NavigationView {
            CameraScannerViewController(
                startScanning: $startScanning,
                showCameraScannerView: $showCameraScannerView,
                scanResult: $scanResult
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    CameraScannerView(
        startScanning: .constant(true),
        showCameraScannerView: .constant(false),
        scanResult: .constant("")
    )
}
