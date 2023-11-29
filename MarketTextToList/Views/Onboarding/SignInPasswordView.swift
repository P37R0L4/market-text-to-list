//
//  SignInPasswordView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI
import Combine

struct SignInPasswordView: View {
    @State var password: String = ""
    @State var showHomeView: Bool = false
    @State var userData: Onboarding!
    @Binding var completePhoneNumber: String
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let hasHomeIndicator = geo.safeAreaInsets.bottom > 0
                
                VStack {
                    TitleOnboadingView(
                        hasHomeIndicator: hasHomeIndicator,
                        text: "Confirm your password"
                    )
                    
                    PasswordInputView(text: $password)
                    
                    Button {
                        handleLogin()
                    } label: {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(OnboardingButtonStyle())
                    .disableWithOpacity(password.count < 1)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationDestination(isPresented: $showHomeView) {
            ContentView()
        }
    }
    
    func handleLogin () {
        FirestoreOnboarding()
            .fetchSignIn(
                number: completePhoneNumber,
                password: password
            ) { user in
                if user.name != "error" {
                    Prefs.shared.sharedPhoneNumber = completePhoneNumber
                    showHomeView = true
                }
            }
    }
}

#Preview {
    SignInPasswordView(completePhoneNumber: .constant(""))
}
