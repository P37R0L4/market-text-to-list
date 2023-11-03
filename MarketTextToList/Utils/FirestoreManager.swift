//
//  StorageManager.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit

class FirestoreManager: ObservableObject {
    @Published var shopping = [ShoppingCard]()
    
    func fetchShopping(document: String) {
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
                    //                    self.shopping = data["name"] as? String ?? ""
                }
            }
            
        }
    }
    
    func update (uid: String, data: [String:Any]) {
        Firestore.firestore().collection("Shopping").document(uid).updateData(data) { err in
            guard err == nil else {
                fatalError("impossible to update")
            }
            
            print("Success")
        }
    }
    
    func fetchAllShopping() {
        let db = Firestore.firestore()
        
        db.collection("Shopping").getDocuments() { (querySnapshot, error) in
            guard error == nil else { return }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.shopping = documents.map { queryDocumentSnapshot -> ShoppingCard in
                let data = queryDocumentSnapshot.data()
                
                let documentID = queryDocumentSnapshot.documentID
                let title = data["title"] as? String ?? ""
                let date = data["data"] as? Date ?? Date()
                let firstPurchase = data["firstPurchase"] as? Bool ?? true
                let isFavorite = data["isFavorite"] as? Bool ?? true
                let itemArr = data["items"] as? [Items] ?? []
                let shareWith = data["shareWith"] as? String ?? ""
                let amount = data["amount"] as? Int ?? 0
                let localization = data["localization"] as? GeoPoint ?? GeoPoint(latitude: 51.5074, longitude: 0.12780)
                
                return ShoppingCard(
                    documentID: documentID,
                    title: title,
                    data: date,
                    firstPurchase: firstPurchase,
                    items: itemArr,
                    shareWith: shareWith,
                    amount: amount,
                    isFavorite: isFavorite,
                    localization: localization
                )
            }
        }
    }
}
