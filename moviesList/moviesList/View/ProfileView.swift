//
//  ProfileView.swift
//  moviesList
//
//  Created by Vera Nur on 14.07.2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isShowing: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.fullName)
                    .font(.headline)
                Text(viewModel.email)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Divider()
            
            Button("Change Password") {
                viewModel.sendPasswordReset()
            }
            .foregroundColor(.blue)
            
            Button("Logout", role: .destructive) {
                authViewModel.logout()
                isShowing = false
                
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 5)
        .frame(maxWidth: 250)
    }
}


