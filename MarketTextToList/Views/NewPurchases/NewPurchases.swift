//
//  CameraView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI

struct NewPurchases: View {
    var body: some View {
        NavigationView {
            VStack {
                NewPurchasesForm()
            }
            .navigationTitle("New Purchases")
            .toolbar {                
                ToolbarItem(placement: .confirmationAction) {
                    Button {} label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

#Preview {
    NewPurchases()
}
