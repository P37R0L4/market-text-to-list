//
//  DetailListView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 09/12/23.
//

import SwiftUI

struct DetailListView: View {
    var title: String
    var price: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20))
                
                Text("$ \(price)")
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

#Preview {
    DetailListView(title: "Ovo Cozido", price: 2)
}
