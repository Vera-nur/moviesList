//
//  ContentView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieListViewModel()
    var body: some View {
        VStack {
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.movies) { movie in
                        Text(movie.title)
                    }
                }
            }
            .onAppear {
                viewModel.fetchPopularMovies()
            }
    }
}

#Preview {
    ContentView()
}
