//
//  SignInPasswordView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI
import Combine

struct SignInPasswordView: View {    
    @Binding var password: String
    @Binding var completePhoneNumber: String
    @Binding var pageIndex: OnboardingIndex
    
    @Binding var showHomeView: Bool
    
    var body: some View {
        GeometryReader { geo in
            let hasHomeIndicator = geo.safeAreaInsets.bottom > 0
            
            VStack {
                TitleOnboadingView(
                    hasHomeIndicator: hasHomeIndicator,
                    text: "Confirm your password"
                )
                
                PasswordInputView(text: $password)
                ConfirmButtonView(
                    completePhoneNumber: completePhoneNumber,
                    showHomeView: $showHomeView,
                    password: $password
                )
                
                Spacer()
            }
            .padding()
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#Preview {
    SignInPasswordView(
        password: .constant(""),
        completePhoneNumber: .constant(""),
        pageIndex: .constant(.password),
        showHomeView: .constant(false)
    )
}
