//
//  FiretorageAuthController.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 04/11/23.
//

import Foundation
import Firebase

class FirestoreAuthController: ObservableObject {
    @Published var lists = [SignInLogin]()
    
    func fetchSignIn(number: String, password: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(number)
        
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
}
