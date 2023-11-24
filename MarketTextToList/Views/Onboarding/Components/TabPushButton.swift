//
//  TabPushButton.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct TabPushButton: View {
    @State var text: String
    @State var indexToReturn: OnboardingIndex
    @Binding var pageIndex: OnboardingIndex
    
    var body: some View {
        Button {
            pageIndex = indexToReturn
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(OnboardingSeccondaryButtonStyle())
        .padding(.top)
    }
}

#Preview {
    TabPushButton(
        text: "Return",
        indexToReturn: .phone,
        pageIndex: .constant(.password)
    )
}
