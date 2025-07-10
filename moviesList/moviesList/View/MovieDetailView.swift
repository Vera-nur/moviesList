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
    }
}


