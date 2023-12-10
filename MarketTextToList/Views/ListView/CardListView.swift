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
    var isFavorite: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.white)
                .padding()
                .background(isFavorite ? .yellow : .secondary)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(title.capitalized)
                    .font(.system(size: 20))
                    .bold()
                
                Text(data.getFormattedDate(format: "MMM d, yyyy"))
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

#Preview {
    CardListView(
        title: "Compras no pirateBay",
        data: Date(),
        isFavorite: false
    )
}
