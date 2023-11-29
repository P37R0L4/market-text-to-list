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
}

struct ShoppingListData: Codable {
    let documentID: String
    let title: String
    let data: Date
    var items: [Items]
    let amount: Int
    let isFavorite: Bool
}

class FirestoreShoppingList {
    func fetchShoppingList(document: String, completion: @escaping (ShoppingListData) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("Shopping").document(document)
        
        docRef.getDocument(as: ShoppingListData.self) { result in
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
