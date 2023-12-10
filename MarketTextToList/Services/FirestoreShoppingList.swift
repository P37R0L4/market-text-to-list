//
//  FirestoreShoppingList.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit

struct Items: Codable {
    let item: String
    let selected: Bool
    let price: Int
}

struct ShoppingListData: Codable {
    var items: [Items]
    let amount: Int
    let owner: String
    let shareWith: String
}

class FirestoreShoppingList {
    func fetchShoppingList(document: String, completion: @escaping (ShoppingListData) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("Shopping")
        
        docRef.addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                for snaphotDocument in snapshot.documents {
                    if snaphotDocument.documentID == document {
                        let data = try! snaphotDocument.data(as: ShoppingListData.self)
                        completion(data)
                    }
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
}
