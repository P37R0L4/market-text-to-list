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
    @State var presentPasswordError: Bool = false
    @State var userData: OnboardingData!
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
                    
                    VStack {
                        SecureField("", text: $password)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.secondary)
                            }
                            .keyboardType(.default)
                    }
                    .padding(10)
                    .frame(minWidth: 80, minHeight: 47)
                    .background(
                        backgroundColor,
                        in: RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous)
                    )
                    .keyboardType(.numberPad)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    
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
                .alert("Invalid password", isPresented: $presentPasswordError) {
                    Button("Close") { }
                }
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
                if user.password != "invalid" {
                    Prefs.shared.sharedPhoneNumber = completePhoneNumber
                    showHomeView = true
                } else {
                    
                }
            }
    }
}

#Preview {
    SignInPasswordView(completePhoneNumber: .constant(""))
}
