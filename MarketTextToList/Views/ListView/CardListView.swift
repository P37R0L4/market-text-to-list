//
//  CardListView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 20/10/23.
//

import SwiftUI
import Firebase

struct CardListView: View {
    var title: String
    var data: Date
    var firstPurchase: Bool
    var shareWith: String
    var isFavorite: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title.capitalized)
                    .bold()
                
                Text("\(data.getFormattedDate(format: "MMM d, yyyy"))")
            }
            
            Spacer()
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(isFavorite ? .yellow : .black)
            
        }
    }
}

#Preview {
    CardListView(
        title: "Churrasco com as putas",
        data: Date(),
        firstPurchase: false,
        shareWith: "all",
        isFavorite: false
    )
}
