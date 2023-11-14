//
//  TabReturnButton.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct TabReturnButton: View {
    @State var indexToReturn: OnboardingIndex
    
    var body: some View {
        Button {
            pageIndex = indexToReturn
        } label: {
            Text("Return")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(OnboardingSeccondaryButtonStyle())
    }
}

#Preview {
    TabReturnButton(
        indexToReturn: .phone)
}
