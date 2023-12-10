//
//  FirestoreOnboarding.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 04/11/23.
//

import Foundation
import Firebase

struct Lists: Codable, Identifiable {
    let id: String
    let data: Date
    let isFavorite: Bool
    let title: String
}

struct OnboardingData: Codable {
    let lists: [Lists]
    let name: String
    let password: String
}

class FirestoreOnboarding {
    func fetchSignIn(number: String, password: String? = nil, completion: @escaping (OnboardingData) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("Users")
        let errorHandler: OnboardingData = OnboardingData(lists: [], name: "", password: "invalid")
        
        docRef.addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        let data = try document.data(as: OnboardingData.self)
                        let documentID = document.documentID
                        
                        if documentID == number {
                            if data.password == password || password == nil {
                                completion(data)
                            } else {
                                completion(errorHandler)
                            }
                        }
                    } catch {
                        print("erro aqui: \(error)")
                    }
                    
                }
            }
        }
    }
}
