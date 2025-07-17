//
//  FavoritesViewModel.swift
//  moviesList
//
//  Created by Vera Nur on 11.07.2025.
//

import Foundation

class FavoritesViewModel : ObservableObject {
    @Published var favoriteMovies: [Movie] = []
    
    private let favoritesKey = "favorite_movies"
    
    init () {
        loadFavorites()
    }
    
    func isFavorite(movie: Movie) -> Bool {
        favoriteMovies.contains(where: { $0.id == movie.id })
    }
    
    func addFavorite(movie: Movie) {
        if !favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.append(movie)
            saveFavorites()
        }
    }
    
    func removeFavorite(movie: Movie) {
        favoriteMovies.removeAll() { $0.id == movie.id }
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            if let movies = try? JSONDecoder().decode([Movie].self, from: data) {
                favoriteMovies = movies
            }
        }
    }
}
