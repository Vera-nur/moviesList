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
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }

                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Rating: \(String(format: "%.1f", movie.vote_average))")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Release Date: \(movie.release_date)")
                    .font(.subheadline)

                Text(movie.overview)
                    .font(.body)
                
            }
            .padding()
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Button(action: {
            isFavorite.toggle()
            /*if isFavorite && !favoriteviewModel.isFavorite(movie: movie) {
                favoriteviewModel.addFavorite(movie: movie)
            }else if !isFavorite && favoriteviewModel.isFavorite(movie: movie) {
                favoriteviewModel.removeFavorite(movie: movie)
            }*/
            //bu şekilde mi daha doğru??
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        )
        .onAppear {
            isFavorite = favoriteviewModel.isFavorite(movie: movie)
        }
        .onDisappear() { // bu olmayınca favorilerden çıkarında direkt favori listesine atıyordu detail kısmında kalmıyordu ama bu da mantıklı mı???
            //ya da o şekilde olması daha mı mantıklıdı
            if isFavorite && !favoriteviewModel.isFavorite(movie: movie) {
                favoriteviewModel.addFavorite(movie: movie)
            }else if !isFavorite && favoriteviewModel.isFavorite(movie: movie) {
                favoriteviewModel.removeFavorite(movie: movie)
            }
        }
    }
}


