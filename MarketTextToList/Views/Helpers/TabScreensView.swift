//
//  ProspectView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 11/10/23.
//

import SwiftUI

struct TabScreensView: View {
    enum FilterType {
        case list, newCard, markets
    }
    
    var body: some View {
        NavigationView {
            switch filter {
            case .list:
                ListView()
                    .navigationTitle(title)
            case .markets:
                NearMarketsView()
                    .navigationTitle(title)
            case .newCard:
                NewPurchases()
                    .navigationTitle(title)
            }
        }
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .list:
            return "Shopping lists"
        case .markets:
            return "Near markets"
        case .newCard:
            return "New Purchases"
        }
    }
}

#Preview {
    TabScreensView(filter: .list)
}
