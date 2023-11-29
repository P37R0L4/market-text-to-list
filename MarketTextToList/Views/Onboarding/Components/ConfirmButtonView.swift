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
    @State var showHomeView: Bool = true
    
    @Binding var password: String
    
    var body: some View {
      
    }

}

#Preview {
    ConfirmButtonView(
        completePhoneNumber: "",
        password: .constant("")
    )
}
