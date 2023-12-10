//
//  NewCardForm.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI

struct NewListForm: View {
    @State private var marketName = ""
    @State private var amount: Double?
    @State private var isFavorite = false
    @State private var generateQRCode = false
    
    @State private var presentAdd = false
    @State private var addShoppingListText = ""
    @State private var shoppingList: [String] = []
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Market info")) {
                TextField("Name list", text: $marketName)
                Toggle("Set Favorite", isOn: $isFavorite)
                Toggle("Generate QRCode", isOn: $generateQRCode)
            }
            
            Section(header: Text("How much you spend here?")) {
                TextField("$0", value: $amount, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                List {
                    ForEach(shoppingList, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: self.deleteItem)
                }
            } header: {
                HStack {
                    Text("Add items to shoping list")
                    Spacer()
                    Button {
                        self.presentAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .alert("Add item to shopping list", isPresented: $presentAdd) {
            TextField("Enter the item here", text: $addShoppingListText)
            
            Button("Add", role: .destructive, action: {
                addItem(nameItem: addShoppingListText)
            })
        }
        .refreshable {
            addItem()
        }
    }
    
    private func addItem(nameItem: String = "") {
        self.shoppingList.append(nameItem)
        self.addShoppingListText = ""
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        self.shoppingList.remove(atOffsets: indexSet)
    }
}

#Preview {
    NewListForm()
}
