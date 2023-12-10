//
//  CameraView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI

struct NewList: View {
    var body: some View {
        NavigationView {
            VStack {
                NewListForm()
            }
            .navigationTitle("New list")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {}
                }
            }
        }
    }
}

#Preview {
    NewList()
}
