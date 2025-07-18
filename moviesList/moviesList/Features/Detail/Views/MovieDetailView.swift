//
//  MovieDetailView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    let movie: Movie
    @EnvironmentObject var favoriteviewModel: FavoritesViewModel
    @State private var isFavorite: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let path = movie.poster_path {
                    ImageView(
                        urlString: "https://image.tmdb.org/t/p/w500\(path)",
                        contentMode: .fill,
                        width: 150,
                        height: 200,
                        cornerRadius: 8
                    )
                }

                Text(movie.title ?? "")
                    .poppinsFont(size: 22, weight: .bold)

                Text("Rating: \(String(format: "%.1f", movie.vote_average ?? 0.0))")
                    .poppinsFont(size: 14)
                    .foregroundColor(.gray)

                Text("Release Date: \(movie.release_date ?? "")")
                    .poppinsFont(size: 14)


                Text(movie.overview ?? "")
                    .poppinsFont(size: 15)
                
            }
            .padding()
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Button(action: {
            isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        )
        .onAppear {
            isFavorite = favoriteviewModel.isFavorite(movie: movie)
        }
        .onDisappear() {
            if isFavorite && !favoriteviewModel.isFavorite(movie: movie) {
                favoriteviewModel.addFavorite(movie: movie)
            }else if !isFavorite && favoriteviewModel.isFavorite(movie: movie) {
                favoriteviewModel.removeFavorite(movie: movie)
            }
        }
    }
}


