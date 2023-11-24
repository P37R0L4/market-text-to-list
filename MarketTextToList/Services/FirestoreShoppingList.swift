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

class FirestoreShoppingList: ObservableObject {
    
    func fetchShopping(document: String, completion: @escaping ([ShoppingList]) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("Shopping").document(document)
        
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            let shoppingList = try! JSONDecoder().decode(ShoppingList.self, from: data)
            
            DispatchQueue.main.sync {
                completion(shoppingList)
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
