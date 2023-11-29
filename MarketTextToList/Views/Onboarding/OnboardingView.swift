//
//  SignInView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var password: String = ""
    @State var completePhoneNumber: String = ""
    
    @State var showHomeView: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: .constant(tabIndex), content:  {
                PhoneNumberView(
                    completePhoneNumber: $completePhoneNumber
                )
                .tabItem {}
                .tag(0)
                
                SignInPasswordView(
                    password: $password,
                    completePhoneNumber: $completePhoneNumber,
                    showHomeView: $showHomeView
                )
                .tabItem {}
                .tag(1)
            })
            .animation(.easeOut(duration: 0.2), value: tabIndex)
            .transition(.slide)
            .onAppear {
                guard let storagePhone = UserDefaults.standard.string(forKey: "completePhoneNumber") else {return}
                
                guard let password = UserDefaults.standard.string(forKey: "password") else {return}
                
                if storagePhone != "" && password != "" {
                    showHomeView = true
                }
            }
            
            NavigationLink(destination: ContentView(), isActive: $showHomeView) { }
        }
    }
}

#Preview {
    OnboardingView()
}
