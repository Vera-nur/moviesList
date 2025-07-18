//
//  EditProfileView.swift
//  moviesList
//
//  Created by Vera Nur on 16.07.2025.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isShowingPasswordView = false
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name").poppinsFont(size: 14, weight: .semibold)) {
                    TextField("First Name", text: $viewModel.firstName).poppinsFont(size: 16)
                    TextField("Last Name", text: $viewModel.lastName).poppinsFont(size: 16)
                }

                Section(header: Text("Phone Number").poppinsFont(size: 14, weight: .semibold)) {
                    TextField("Phone", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                        .poppinsFont(size: 16)
                }

                Section(header: Text("Birth Date").poppinsFont(size: 14, weight: .semibold)) {
                    DatePicker("Birth Date", selection: $viewModel.birthDate, displayedComponents: .date)
                        .poppinsFont(size: 16)
                }

                Section {
                    Button("Save Changes") {
                        viewModel.updateProfile()
                        dismiss()
                    }
                    .poppinsFont(size: 16, weight: .semibold)
                }
                Section(header: Text("Account Security").poppinsFont(size: 14, weight: .semibold)) {
                    Button("Change Password") {
                        isShowingPasswordView = true
                    }
                    .foregroundColor(.blue)
                    .poppinsFont(size: 16)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchUserInfo()
            }
            .sheet(isPresented: $isShowingPasswordView){
                    ChangePasswordView(viewModel: viewModel)
            }
        }
    }
}

