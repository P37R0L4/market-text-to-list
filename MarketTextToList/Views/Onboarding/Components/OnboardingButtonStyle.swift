//
//  OnboardingButtonStyle.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .frame(height: 49)
                .foregroundColor(.accentColor)
            
            configuration.label
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}
