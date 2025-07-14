//
//  UserProfileViewModel.swift
//  moviesList
//
//  Created by Vera Nur on 14.07.2025.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserProfileViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var fullName: String = ""

    init() {
        fetchUserInfo()
    }

    func fetchUserInfo() {
        guard let user = Auth.auth().currentUser else { return }
        self.email = user.email ?? ""

        let ref = Database.database().reference()
        ref.child("users").child(user.uid).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any],
               let firstName = data["firstName"] as? String,
               let lastName = data["lastName"] as? String {
                DispatchQueue.main.async {
                    self.fullName = "\(firstName) \(lastName)"
                }
            }
        }
    }

    func sendPasswordReset() {
        if let email = Auth.auth().currentUser?.email {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Password reset error: \(error.localizedDescription)")
                } else {
                    print("Password reset email sent.")
                }
            }
        }
    }
}
