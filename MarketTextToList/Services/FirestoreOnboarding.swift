//
//  FirestoreOnboarding.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 04/11/23.
//

import Foundation
import Firebase

struct OnboardingData: Codable {
    let lists: [String]
    let name: String
    let password: String
}

class FirestoreOnboarding: ObservableObject {
    func fetchSignIn(number: String, password: String, completion: @escaping (OnboardingData) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(number)
        let errorHandler: OnboardingData = OnboardingData(lists: [], name: "error", password: "")
        
        docRef.getDocument(as: OnboardingData.self) { result in
            switch result {
            case .success(let user):
                if password == user.password {
                    completion(user)
                } else {
                    completion(errorHandler)
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
