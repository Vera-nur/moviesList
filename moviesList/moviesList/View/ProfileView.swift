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
    @State private var isEditing = false

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
            
            Button("Edit Profile") {
                isEditing = true
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
        .sheet(isPresented: $isEditing){
            EditProfileView(viewModel: viewModel)
        }
    }
}


