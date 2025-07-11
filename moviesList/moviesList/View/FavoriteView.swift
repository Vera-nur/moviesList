//
//  FavoriteView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoriteViewModel: FavoritesViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            if favoriteViewModel.favoriteMovies.isEmpty {
                Text("You have no favorite movies yet.")
                    .foregroundColor(.gray)
                    .padding()
            }else{
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(favoriteViewModel.favoriteMovies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieGridItemView(movie: movie)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorites")
            }
        }
    }
}

#Preview {
    FavoriteView()
}
