//
//  LoginView.swift
//  moviesList
//
//  Created by Vera Nur on 14.07.2025.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var isShowingRegister = false
    @State private var isShowingResetPassword = false

    var body: some View {
        VStack(spacing: 20) {
            
            Image("Logo".localized())
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .padding(.top, 40)

            Text("Welcome".localized())
                .poppinsFont(size: 24, weight: .semibold)

            CustomTextField(title: "Email".localized(), text: $viewModel.email, keyboardType: .emailAddress)
            SecureInputField(title: "Password".localized(), text: $viewModel.password)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .poppinsFont(size: 12)
            }

            Button(action: {
                viewModel.login()
            }) {
                Text("Login".localized())
                    .poppinsFont(size: 16, weight: .semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton {
                viewModel.signInWithGoogle()
            }
            .frame(height: 50)
            .padding(.horizontal)
            
            
            Button("Forgot password?".localized()) {
                isShowingResetPassword = true
            }
            .poppinsFont(size: 12)
            .foregroundColor(.blue)
            .sheet(isPresented: $isShowingResetPassword) {
                ForgotPasswordView()
                    .presentationDetents([.fraction(0.35)])
                    .presentationDragIndicator(.visible)
            }
            

            Button("Don't have an account? Register".localized()) {
                isShowingRegister = true
            }
            .poppinsFont(size: 12)
            .padding(.top, 5)

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            ContentView()
                .environmentObject(viewModel)
        }
        .sheet(isPresented: $isShowingRegister) {
            RegisterView()
        }
    }
}

#Preview {
    LoginView()
}
