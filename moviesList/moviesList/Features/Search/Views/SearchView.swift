//
//  SearchView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a movie...".localized(), text: $viewModel.query, onCommit: {
                    viewModel.search()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .poppinsFont(size: 16)

                if viewModel.isLoading {
                    ProgressView("Searching...".localized())
                        .padding()
                        .poppinsFont(size: 16)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                        .poppinsFont(size: 14)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
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
            .navigationTitle("Search".localized())
        }
    }
}

#Preview {
    SearchView()
}
