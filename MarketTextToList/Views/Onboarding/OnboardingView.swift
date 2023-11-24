//
//  SignInView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var pageIndex: OnboardingIndex
    @State var password: String = ""
    @State var completePhoneNumber: String = ""
    
    @State var showHomeView: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: .constant(tabIndex), content:  {
                PhoneNumberView(
                    completePhoneNumber: $completePhoneNumber,
                    pageIndex: $pageIndex
                )
                .tabItem {}
                .tag(0)
                
                SignInPasswordView(
                    password: $password,
                    completePhoneNumber: $completePhoneNumber,
                    pageIndex: $pageIndex,
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
            }
            
            NavigationLink(destination: ContentView(), isActive: $showHomeView) { }
        }
    }
    
    var tabIndex: Int {
        switch pageIndex {
        case .phone:
            return 0
        case .password:
            return 1
        }
    }
}

#Preview {
    OnboardingView(pageIndex: .phone)
}
