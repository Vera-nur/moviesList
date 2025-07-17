//
//  MovieGridItemView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI
import Kingfisher

struct MovieGridItemView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            ImageView(
                urlString: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")",
                contentMode: .fill,
                width: UIScreen.main.bounds.width / 2 - 20,
                height: 180,
                isClipped: true
            )
            Text(movie.title ?? "")
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 160)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}


