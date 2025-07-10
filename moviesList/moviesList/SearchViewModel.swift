//
//  SearchViewModel.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var movies: [Movie] = []

    func search() {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        isLoading = true
        errorMessage = nil

        TMDBService.searchMovies(query: query) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    self.errorMessage = "Sorry, we couldn't find any results: \(error.localizedDescription)"
                    self.movies = []
                }
            }
        }
    }
}
