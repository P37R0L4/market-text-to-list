//
//  SignInView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var pageIndex: OnboardingIndex
    
    var body: some View {
        if pageIndex == .phone {
            PhoneNumberView(pageIndex: $pageIndex)
        } else {
            SignInPasswordView()
        }
    }
}

#Preview {
    OnboardingView(pageIndex: .phone)
}
