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
                Section(header: Text("Name")) {
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                }

                Section(header: Text("Phone Number")) {
                    TextField("Phone", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Birth Date")) {
                    DatePicker("Birth Date", selection: $viewModel.birthDate, displayedComponents: .date)
                }

                Section {
                    Button("Save Changes") {
                        viewModel.updateProfile()
                        dismiss()
                    }
                }
                Section(header: Text("Account Security")) {
                    Button("Change Password") {
                        isShowingPasswordView = true
                    }
                    .foregroundColor(.blue)
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

