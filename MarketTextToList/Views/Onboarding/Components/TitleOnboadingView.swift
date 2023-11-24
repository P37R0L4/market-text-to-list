//
//  TitleOnboadingView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct TitleOnboadingView: View {
    @State var hasHomeIndicator: Bool
    @State var text: String
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.title).bold()
            .padding(.top, hasHomeIndicator ? 70 : 20)
    }
}

#Preview {
    TitleOnboadingView(
        hasHomeIndicator: true,
        text: "Confirm country code and enter phone number"
    )
}
