//
//  ProspectView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI

struct TabScreensView: View {
    var body: some View {
        switch filter {
        case .list:
            ListView()
            
        case .markets:
            NearMarketsView()
                .navigationTitle(title)
        case .newCard:
            NewPurchases()
                .navigationTitle(title)
        }
    }
    
    
}

#Preview {
    TabScreensView(filter: .list)
}
