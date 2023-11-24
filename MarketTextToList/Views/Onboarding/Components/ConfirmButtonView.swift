//
//  ConfirmButtonView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct ConfirmButtonView: View {
    @State var completePhoneNumber: String
    @State var showAlert = false
    
    @Binding var showHomeView: Bool
    @Binding var password: String
    
    var body: some View {
        Button {
            FirestoreOnboarding()
                .fetchSignIn(
                    number: completePhoneNumber,
                    password: password
                ) { user in
                    let userData = UserDefaults().data(forKey: "userData")
                    
                    if userData == nil {
                        UserDefaults.standard.set(completePhoneNumber, forKey: "completePhoneNumber")
                    } else {
                        showHomeView = true
                    }
                }
        } label: {
            Text("Submit")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(OnboardingButtonStyle())
        .disableWithOpacity(password.count < 1)
    }
}

#Preview {
    ConfirmButtonView(
        completePhoneNumber: "",
        showHomeView: .constant(false),
        password: .constant("")
    )
}
