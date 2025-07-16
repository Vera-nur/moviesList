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
        VStack(spacing: 20) {
            Text("Create Your Account")
                .font(.title2)
                .bold()
                .padding(.top, 40)

            VStack(spacing: 15) {
                Group {
                    CustomTextField(title: "First Name", text: $viewModel.firstName)
                    CustomTextField(title: "Last Name", text: $viewModel.lastName)

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Birth Date")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        DatePicker("", selection: $viewModel.birthDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                    }

                    CustomTextField(title: "Phone Number", text: $viewModel.phoneNumber, keyboardType: .phonePad)
                    CustomTextField(title: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                    SecureInputField(title: "Password", text: $viewModel.password)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)

            Button(action: {
                viewModel.register()
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            Button("Back to Login") {
                dismiss()
            }
            .font(.footnote)
            .padding(.top, 5)

            Spacer()
        }
        .onChange(of: viewModel.registrationSuccess) { success in
            if success {
                dismiss()
            }
        }
    }
}
