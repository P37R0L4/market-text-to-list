//
//  StorageManager.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    @Published var shopping: String = ""
    
    init() {
        self.fetchAllShopping()
    }
    
    public func fetchShopping(document: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("Shopping").document(document)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                
                if let data = data {
                    print("data", data)
                    self.shopping = data["name"] as? String ?? ""
                }
            }
            
        }
    }
    
    public func fetchAllShopping() {
        let db = Firestore.firestore()
        
        db.collection("Shopping").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    self.shopping = "\(document.documentID): \(document.data())"
                }
            }
        }
    }
}
