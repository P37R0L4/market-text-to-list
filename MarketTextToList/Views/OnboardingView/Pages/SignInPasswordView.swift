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
    @FocusState private var keyIsFocused: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            let hasHomeIndicator = geo.safeAreaInsets.bottom > 0
            
            NavigationStack {
                VStack {
                    
                    Text("Confirm your password")
                        .multilineTextAlignment(.center)
                        .font(.title).bold()
                        .padding(.top, hasHomeIndicator ? 70 : 20)
                    
                    VStack {
                        TextField("", text: $password)
                            .placeholder(when: password.isEmpty) {
                                Text("Phone number")
                                    .foregroundColor(.secondary)
                            }
                            .focused($keyIsFocused)
                            .keyboardType(.numbersAndPunctuation)
                    }
                    .padding(10)
                    .frame(minWidth: 80, minHeight: 47)
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .focused($keyIsFocused)
                    .keyboardType(.numberPad)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    
                    Button { } label: {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(OnboardingButtonStyle())
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
    
    var foregroundColor: Color {
        if colorScheme == .dark {
            return Color(.white)
        } else {
            return Color(.black)
        }
    }
}

#Preview {
    SignInPasswordView()
}
