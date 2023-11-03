//
//  MarketsView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI

struct NearMarketsView: View {
    var body: some View {
        NavigationView {
            Text("Markets")
                .navigationTitle("Near markets")
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
    NearMarketsView()
}
