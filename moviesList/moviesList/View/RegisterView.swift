//
//  RegisterView.swift
//  moviesList
//
//  Created by Vera Nur on 14.07.2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                TextField("First Name", text: $viewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Last Name", text: $viewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                DatePicker("Birth Date", selection: $viewModel.birthDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())

                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }

                Button("Register") {
                    viewModel.register()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)

                Button("Back to Login") {
                    dismiss()
                }
                .font(.caption)
            }
            .padding()
        }
        .navigationTitle("Create Account")
    }
}

#Preview {
    RegisterView()
}
