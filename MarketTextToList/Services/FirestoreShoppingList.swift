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

class FirestoreShoppingList {
    func fetchShoppingList(document: String, completion: @escaping (ShoppingList) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("Shopping").document(document)
        
        docRef.getDocument(as: ShoppingList.self) { result in
            switch result {
            case .success(let shoppingList):
                completion(shoppingList)
            case .failure(let error):
                print("\(error)")
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
