//
//  NewCardForm.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import SwiftUI

struct NewPurchasesForm: View {
    @State private var marketName = ""
    @State private var amount: Double?
    @State private var firstPurchase = false
    @State private var shareLocalization = false
    @State private var itemsNumber: String?
    
    @State private var showAddShoppngList = false
    @State private var addShoppingListText = ""
    
    @State private var shoppingList: [String] = []
    
    enum ShareWith: String, CaseIterable, Identifiable {
        case all, friends, me
        var id: Self {self}
    }
    
    @State private var shareWith: ShareWith = .all
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var intFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Market info")) {
                TextField("Market name", text: $marketName)
                Toggle("First purchase here?", isOn: $firstPurchase)
                Toggle("Share market localization?", isOn: $shareLocalization)
                
                Picker("Share with", selection: $shareWith) {
                    Text("All").tag(ShareWith.all)
                    Text("Only my contacts").tag(ShareWith.friends)
                    Text("Only me").tag(ShareWith.me)
                }
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
                        self.showAddShoppngList = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .alert("Add item to shopping list", isPresented: $showAddShoppngList) {
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
    NewPurchasesForm()
}
