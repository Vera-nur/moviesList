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
                    SecureField("Current Password", text: $viewModel.currentPassword).poppinsFont(size: 16)
                    SecureField("New Password", text: $viewModel.newPassword).poppinsFont(size: 16)
                    SecureField("Confirm New Password", text: $viewModel.confirmPassword).poppinsFont(size: 16)

                    if !viewModel.passwordChangeMessage.isEmpty {
                        Text(viewModel.passwordChangeMessage)
                            .foregroundColor(.red)
                            .poppinsFont(size: 13)
                    }

                    Button("Save Password") {
                        viewModel.updatePassword()
                    }
                    .foregroundColor(.blue)
                    .poppinsFont(size: 16, weight: .semibold)
                }
            }
            .navigationTitle("Change Password")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .poppinsFont(size: 16)
                }
            }
        }
    }
}
