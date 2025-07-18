//
//  HomeView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @StateObject private var profileViewModel = UserProfileViewModel()
    @State private var isShowingProfile = false
    @EnvironmentObject var authViewModel: AuthViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .poppinsFont(size: 16)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieGridItemView(movie: movie)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                
                if isShowingProfile {
                    VStack {
                        HStack {
                            Spacer()
                            ProfileView(viewModel: profileViewModel, isShowing: $isShowingProfile)
                                .padding()
                        }
                        Spacer()
                    }
                    .transition(.move(edge: .top))
                    .zIndex(1)
                }
            }
            .navigationTitle("Popular Movies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isShowingProfile.toggle()
                        }
                    }) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPopularMovies()
        }
    }
}

#Preview {
    HomeView()
}
