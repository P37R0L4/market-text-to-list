//
//  ConfirmButtonView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct ConfirmButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            SecureField("", text: $text)
                .placeholder(when: text.isEmpty) {
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
    ConfirmButtonView(text: .constant(""))
}
