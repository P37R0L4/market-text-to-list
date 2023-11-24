//
//  FiretorageAuthController.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 04/11/23.
//

import Foundation
import Firebase

class FirestoreOnboarding: ObservableObject {
    @Published var firestoreUserData = [String: Any]()
    
    func fetchSignIn(number: String, password: String, completion: @escaping () -> Void, isError: @escaping () -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(number)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let passwordReceived = data?["password"] as? String ?? ""
                
                if passwordReceived == password {
                    if let data = data {
                        self.firestoreUserData = data
                        
                        completion()
                    }
                } else {
                    isError()
                }
            } else {
                isError()
            }
        }
    }
}
