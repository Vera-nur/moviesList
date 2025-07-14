//
//  LoginView.swift
//  moviesList
//
//  Created by Vera Nur on 14.07.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var isShowing = false
    var body: some View {
        VStack(spacing:20){
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            HStack {
                Button("Login"){
                    viewModel.login()
                }
                
                Button("Register"){
                    isShowing = true
                }
            }
            
            
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isAuthenticated){
            HomeView()
                .environmentObject(viewModel)
        }
        .sheet(isPresented: $isShowing){
            RegisterView()
        }
        
    }
}

#Preview {
    LoginView()
}
