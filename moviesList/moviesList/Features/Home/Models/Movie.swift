//
//  Movie.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import Foundation

struct Movie : Identifiable, Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let vote_average: Double?
}


struct MovieResponse: Codable {
    let results: [Movie]?
}
