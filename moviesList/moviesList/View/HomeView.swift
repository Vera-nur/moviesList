//
//  HomeView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MovieListViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
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
                .navigationTitle("Popular Movies")
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
