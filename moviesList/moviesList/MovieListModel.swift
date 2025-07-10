//
//  MovieListModel.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchPopularMovies() {
        isLoading = true
        TMDBService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.movies = []
                    self?.errorMessage = "Failed to load movies: \(error.localizedDescription)"
                }
            }
        }
    }
}
