//
//  OnboardingSeccondButtonStyle.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI

struct OnboardingSeccondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .frame(height: 49)
                .foregroundColor(Color(.systemGray5))
            
            configuration.label
                .fontWeight(.semibold)
                .foregroundColor(Color(.black))
        }
    }
}
