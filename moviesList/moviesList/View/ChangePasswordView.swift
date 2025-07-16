//
//  ChangePasswordView.swift
//  moviesList
//
//  Created by Vera Nur on 16.07.2025.
//

import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    SecureField("Current Password", text: $viewModel.currentPassword)
                    SecureField("New Password", text: $viewModel.newPassword)
                    SecureField("Confirm New Password", text: $viewModel.confirmPassword)

                    if !viewModel.passwordChangeMessage.isEmpty {
                        Text(viewModel.passwordChangeMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button("Save Password") {
                        viewModel.updatePassword()
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Change Password")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
