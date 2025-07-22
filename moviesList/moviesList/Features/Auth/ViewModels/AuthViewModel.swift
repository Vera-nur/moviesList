//
//  AuthViewModel.swift
//  moviesList
//
//  Created by Vera Nur on 14.07.2025.
//


import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import UIKit


class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    init() {
        observeAuthState()
    }

    private func observeAuthState() {
        Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                if let user = user {
                    self.email = user.email ?? ""
                    self.isAuthenticated = true
                } else {
                    self.isAuthenticated = false
                }
            }
        }
    }
    

    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("No root view controller found.")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Google Sign-In error: \(error.localizedDescription)"
                return
            }

            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                self?.errorMessage = "Google credentials are missing."
                return
            }

            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { _, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.errorMessage = "Firebase Sign-In failed: \(error.localizedDescription)"
                    } else {
                        self?.isAuthenticated = true
                    }
                }
            }
        }
    }
    
    
    func login() {
        AuthManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isAuthenticated = true
                case .failure(let error as NSError):
                    switch AuthErrorCode(rawValue: error.code) {
                    case .wrongPassword:
                        self.errorMessage = "Incorrect password. Please try again."
                    case .invalidEmail:
                        self.errorMessage = "Invalid email format."
                    case .userNotFound:
                        self.errorMessage = "No user found with this email."
                    case .userDisabled:
                        self.errorMessage = "This user account has been disabled."
                    case .networkError:
                        self.errorMessage = "Network error. Check your connection."
                    default:
                        self.errorMessage = "Login failed: \(error.localizedDescription)"
                    }
                default:
                    self.errorMessage = "An unknown error occurred."
                }
            }
        }
    }

    func register() {
        AuthManager.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isAuthenticated = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func logout() {
        do {
            try AuthManager.shared.logout()
            DispatchQueue.main.async {
                self.email = ""
                self.password = ""
                self.errorMessage = nil
                self.isAuthenticated = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func resetPassword(email: String) {
        guard !email.isEmpty else {
            self.errorMessage = "Please enter your email to reset password."
            return
        }

        AuthManager.shared.sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Reset failed: \(error.localizedDescription)"
                } else {
                    self.errorMessage = "Password reset email sent. Please check your inbox."
                }
            }
        }
    }
}
